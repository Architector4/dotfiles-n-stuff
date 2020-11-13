#!/usr/bin/env python3

import random
import os

responses=[
"ЧО",
"НЕ",
"НИХАЧУ",
"ДАВАЙ ПОТОМ",
"ПАЛЕГЧЕ",
"НЕ ТУДА ПОПАЛ",
"ЭЭЭЭЭЭЭЭЭЭЭЭЭЭЭЭЭЭЭЭЭЭЭЭЭЭЭ",
"Боюсь я тебе не могу это позволить, Дэйв.",
"ЧАВО",
"НИ ТЫКАЙ\n!!!!!!!!!!!!!!!!!!!!!",
"НЕЕЕЕЕЕЕ",
"КОГДА",
"К ЧЕМУ ЭТО",
"КУДА ТЫКНУЛ?? НЕ ТУДА ТЫКНУЛ!!",
"А"
]

response=random.randint(0,len(responses)-1)

#print(responses[response])

os.popen("notify-send \""+responses[response]+"\"","r")
