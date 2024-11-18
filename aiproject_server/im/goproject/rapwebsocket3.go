package main

import (
    "encoding/json"
    "fmt"
    "log"
    "net/http"
    "sync"

    "github.com/gorilla/websocket"
)

// 用户列表
var allUserList = make(map[string]interface{})

// 读写锁保护用户列表
var userListLock sync.RWMutex

// 消费者
func consumer(queue chan map[string]interface{}) {
    for item := range queue {
        if item["type"] == "join" {
            userData, ok := item["data"].(map[string]interface{})
            if ok {
                userListLock.Lock()
                allUserList[userData["account"].(string)] = userData
                userListLock.Unlock()
                fmt.Printf("加入用户成功, 当前用户数量:%d\n", len(allUserList))
            }
        } else if item["type"] == "leave" {
            userData, ok := item["data"].(map[string]interface{})
            if ok {
                userListLock.Lock()
                delete(allUserList, userData["account"].(string))
                userListLock.Unlock()
                fmt.Printf("删除用户成功, 当前用户数量:%d\n", len(allUserList))
            }
        }
    }
}

func echo(w http.ResponseWriter, r *http.Request, queue chan map[string]interface{}) {
    upgrader := websocket.Upgrader{}
    conn, err := upgrader.Upgrade(w, r, nil)
    if err!= nil {
        log.Println(err)
        return
    }
    defer conn.Close()

    account := ""
    for {
        _, message, err := conn.ReadMessage()
        if err!= nil {
            log.Println(err)
            if account!= "" {
                queue <- map[string]interface{}{
                    "type": "leave",
                    "data": map[string]interface{}{
                        "account": account,
                    },
                }
            }
            break
        }

        var jsonData map[string]interface{}
        err = json.Unmarshal(message, &jsonData)
        if err!= nil {
            log.Println(err)
            continue
        }

        if jsonData["type"] == "join" {
            // 用户进入(缺: 查询过程, 得到用户信息)
            userData, ok := jsonData["data"].(map[string]interface{})
            if ok {
                account = userData["account"].(string)
                queue <- jsonData

                // 答复给用户
                response := map[string]interface{}{
                    "code":    1,
                    "message": "success",
                }
                responseBytes, err := json.Marshal(response)
                if err!= nil {
                    log.Println(err)
                    continue
                }
                err = conn.WriteMessage(websocket.TextMessage, responseBytes)
                if err!= nil {
                    log.Println(err)
                    return
                }
            }
        }
    }
}

func main() {
    queue := make(chan map[string]interface{})
    go consumer(queue)

    http.HandleFunc("/", func(w http.ResponseWriter, r *http.Request) {
        echo(w, r, queue)
    })

    log.Fatal(http.ListenAndServe("127.0.0.1:8000", nil))
}