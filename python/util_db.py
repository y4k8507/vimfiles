import vim
import sqlite3


def data_reference():

    # Get an argument
    sqlite3_path = vim.eval("g:sqlite3_path")
    table_name = vim.eval("s:table_name")

    # Open
    conn = sqlite3.connect(sqlite3_path)
    cur = conn.cursor()

    if table_name == "daily_data":
        # Get an argument
        stock_code = vim.eval("s:stock_code")

        sql = 'select * from ' + table_name
        sql += ' where stock_code = "{}"'.format(stock_code)
        sql += ' order by trade_date desc'
        cur.execute(sql)

        rlist = list()
        # Header
        rlist.append("|銘柄コード|日付|始値|高値|低値|終値|出来高|調整後終値|")

    elif table_name == "owned_stock":
        sql = 'select * from ' + table_name
        sql += ' order by trade_date desc'
        cur.execute(sql)

        rlist = list()
        # Header
        rlist.append("|日付|銘柄コード|売買|価格|数量|手数料|損益|")

    else:
        # 処理終了
        return

    # Data
    for row in cur.fetchall():
        buf_list = map(str, row)
        data = "|".join(buf_list)
        data = "|" + data + "|"

        rlist.append(data)

    # Close
    conn.close()

    # return
    rstr = "\n".join(rlist)
    vim.command('let @* = "' + rstr + '"')


def table_initialize():

    # Get an argument
    sqlite3_path = vim.eval("g:sqlite3_path")

    # Open
    conn = sqlite3.connect(sqlite3_path)
    cur = conn.cursor()

    ####################
    # daily_data       #
    ####################
    # drop table
    sql = 'drop table if exists daily_data'
    cur.execute(sql)
    # create table
    sql = 'CREATE TABLE daily_data(' \
    	  'stock_code text not null,' \
    	  'trade_date text not null,' \
    	  'start_price integer not null,' \
    	  'high_price integer not null,' \
    	  'low_price integer not null,' \
    	  'end_price integer not null,' \
    	  'volume integer not null,' \
    	  'adjusted_closing_price integer not null,' \
    	  'primary key(stock_code, trade_date))'
    cur.execute(sql)
    
    ####################
    # owned_stock      #
    ####################
    # drop table
    sql = 'drop table if exists owned_stock'
    cur.execute(sql)
    # create table
    sql = 'CREATE TABLE owned_stock(' \
          'trade_date text not null,' \
          'stock_code text not null,' \
          'buy_sell text not null,' \
          'price integer not null,' \
          'amount integer not null,' \
          'fee integer not null,' \
          'profit_loss integer not null,' \
          'primary key(trade_date, stock_code))'
    cur.execute(sql)

    # Close
    conn.close()


if __name__ == "__main__":

    exec_type = vim.eval("s:exec_type")

    if exec_type == "ref":
        data_reference()

    elif exec_type == "init_table":
        table_initialize()
