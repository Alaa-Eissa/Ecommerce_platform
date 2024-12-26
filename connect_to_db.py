import pymysql
import sys


sys.stdout.reconfigure(encoding='utf-8')


try:
    connection = pymysql.connect(
        host="localhost",  
        user="root",  
        password="Natigaa@2022",   
        database="ecommerce_platform"   
    )

    
    if connection.open:
        print("\u062a\u0645 \u0627\u0644\u0627\u062a\u0635\u0627\u0644 \u0628\u0646\u062c\u0627\u062d \u0628\u0642\u0627\u0639\u062f\u0629 \u0627\u0644\u0628\u064a\u0627\u0646\u0627\u062a!")

except pymysql.MySQLError as err:
    print(f"حدث خطأ: {err}")

finally:
    if connection.open:
        connection.close()  
        print("\u062a\u0645 \u063a\u0644\u0642 \u0627\u0644\u0627\u062a\u0635\u0627\u0644.")
