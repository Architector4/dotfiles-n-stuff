#!/usr/bin/env python3

import random, subprocess

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

response=random.choice(responses)
subprocess.call(['notify-send', response], shell=False)
