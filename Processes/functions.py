import os
import openpyxl
from pathlib import Path
from random import randrange

def randomNumber(min,max):
    return randrange(int(min), int(max))

def NumJob(NumJob):
    return NumJob[4:8]

def subDate(DateDate):
    return DateDate[0:10]

def ProductPrice(PPrice):
    if PPrice.find("(")!=-1:
       return PPrice[4:PPrice.index("(")]
    else:
        return PPrice[4:]


def ProductPrice1(PPrice):
    return PPrice[4:]

def substringg(string1):
    return string1[1:]


def multiple10(num):
    return (float(num))*10

def cutComma(string1):
    return string1.replace(',', '')

def ReadInput(column,row):
    pathFile= os.path.join(Path(Path(__file__).parent).parent,'Input Files\\Input.xlsx')
    inputFile = openpyxl.load_workbook(pathFile)
    sheet=inputFile["Sheet1"]
    x=sheet.cell(int(row),int(column))
    return str(x.value)
