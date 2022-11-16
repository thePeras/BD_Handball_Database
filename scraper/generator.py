from random import random

class Generator:
    
    @staticmethod
    def events():
        # gerar golos
        # gerar sanções
        return []

    @staticmethod
    def timeout():
        return str(random.randint(10, 60)) + ':' + str(random.randint(10, 60))

    @staticmethod
    def birthday():
        return '12-02-1998'