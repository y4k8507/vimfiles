import vim
import sqlite3


def db_connect(db_name: str):
    return sqlite3.connect(db_name)


def db_disconnect(conn):
    conn.close()


def getTableList(conn):
    cur = conn.cursor()

    result = cur.execute('select * from sqlite_master where type="table"')
    rlist = list()
    for row in result:
        rlist.append(row[2])

    return rlist


if __name__ == "__main__":

    # Get an argument from Vim
    exe_type = vim.eval("s:exe_type")

    # Open
    conn = db_connect("C:/Users/User/vimfiles/db/Finance.sqlite3")

    # Execute and Return
    if exe_type == "get_table_list":
        rlist = getTableList(conn)

        vim.command('let s:result_select = "' + ",".join(rlist) + '"')

    # Close
    db_disconnect(conn)
