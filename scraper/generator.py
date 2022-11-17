import random

class Generator:
    
    @staticmethod
    def time(times):
        minuto = random.randint(0, 60)
        segundo = random.randint(0, 60)
        new_time = [minuto, segundo]
        while(new_time not in times):
            minuto = random.randint(0, 60)
            segundo = random.randint(0, 60)
            new_time = [minuto, segundo]
        return new_time

    @staticmethod
    def birthday():
        return '12-02-1998'