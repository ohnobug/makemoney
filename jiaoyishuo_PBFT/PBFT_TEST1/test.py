import asyncio

async def sayHello():
    await asyncio.sleep(10)
    print("hello")

async def main():
    asyncio.create_task(sayHello())

asyncio.run(main())