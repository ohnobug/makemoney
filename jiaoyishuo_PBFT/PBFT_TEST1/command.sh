echo "" > node1.log
echo "" > node2.log
echo "" > node3.log
echo "" > node4.log

python server.py -c server_config1.yaml -l node1.log &
python server.py -c server_config2.yaml -l node2.log &
python server.py -c server_config3.yaml -l node3.log &
python server.py -c server_config4.yaml -l node4.log &

