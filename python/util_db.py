import vim
import sqlite3


if __name__ == "__main__":

    # Get an argument
    stock_code = vim.eval("s:stock_code")
    sqlite3_path = vim.eval("g:sqlite3_path")

    # Open
    conn = sqlite3.connect(sqlite3_path)
    cur = conn.cursor()

    sql = 'select * from daily_data where stock_code = "{}"'.format(stock_code)
    cur.execute(sql)

    rlist = list()
    # Header
    rlist.append("|銘柄コード|日付|始値|高値|低値|終値|出来高|調整後終値|")

    # Data
    for row in cur.fetchall():
        buf_list = map(str, row)
        daily_data = "|".join(buf_list)
        daily_data = "|" + daily_data + "|"

        rlist.append(daily_data)

    # Close
    conn.close()

    # return
    rstr = "\n".join(rlist)
    vim.command('let @* = "' + rstr + '"')
