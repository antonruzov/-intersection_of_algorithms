import pandas as pd
import pyodbc

def read_data(path_to_read=r'C:\Users\Anton\Desktop\intersection of work algorithms'):
    df = pd.read_excel(path_to_read, sheet_name='to_python')
    return df


class ToSql:
    def __init__(self):
        self.data_to_sql = read_data()
        try:
            self.conn = pyodbc.connect('Driver={SQL Server};'
                                       'Server=DESKTOP-9767NU0\SQLEXPRESS;'
                                       'Database=DataBase;'
                                       'Trusted_Connection=yes;')
            self.cursor = self.conn.cursor()
            print('Successful db connection')
        except pyodbc.DatabaseError as err:
            print('Fail db connection: {}'.format(err))
        
    def close_db_connection(self):
        self.cursor.close()
        self.conn.close()
        print('Close db connection')
        
    def write_to_sql(self):
        df = self.data_to_sql.copy()
        for i in range(998, df.shape[0] + 1000, 998):
            query = """set language english;
                       insert into [DataBase].[dbo].[ВремяРаботыАлгоритма] values """
            for k in range(1, 999):
                if (i-k) < df.shape[0]:
                    if k == 998:
                        query = query + """('{}', '{}', '{}')""".format(df.iloc[i-k][0], df.iloc[i-k][1], df.iloc[i-k][2])
                    else:
                        query = query + """('{}', '{}', '{}'), """.format(df.iloc[i-k][0], df.iloc[i-k][1], df.iloc[i-k][2])
            self.cursor.execute(query)
            self.conn.commit()
        print('write data is compleated')
        self.close_db_connection()
                        
    
if __name__ == '__main__':
    ToSql = ToSql()
    df = ToSql.data_to_sql
    ToSql.write_to_sql()
    
    
            