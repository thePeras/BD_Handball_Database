import random

class Generator:
    
    @staticmethod
    def time(times):
        minuto = random.randint(0, 60)
        segundo = random.randint(0, 60)
        new_time = [minuto, segundo]
        while(new_time in times):
            minuto = random.randint(0, 60)
            segundo = random.randint(0, 60)
            new_time = [minuto, segundo]
        return new_time

    @staticmethod
    def birthday():
        year = random.randint(1970, 1995)
        month = random.randint(1, 12)
        day = random.randint(1, 28)
        return f'{year}-{month}-{day}'