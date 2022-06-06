import discord
import os
import requests
import json
import re

client = discord.Client()

discord_token = os.environ.get('DISCORD_TOKEN')
endpoint_cifar10 = "http://alb-fast-api-model-serving-v2-1905986998.us-east-1.elb.amazonaws.com:8000/predict/cifar10?url="


def predict(url):
    response = requests.get(url)
    pretty_json = json.loads(response.text)
    return pretty_json

@client.event
async def on_ready():
    print('We have logged in as {0.user}'.format(client))

@client.event
async def on_message(message):

    if message.author == client.user:
        return
    
    if message.content.startswith('?predict cifar10'):
        m = re.search('\?predict cifar10 (.*)', message.content)
        url = m.group(1)
        response = predict(endpoint_cifar10 + url)
        await message.channel.send(json.dumps(response, indent=2))
    
   
client.run(discord_token)
