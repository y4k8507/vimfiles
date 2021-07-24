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


def selectAll(conn):
    cur = conn.cursor()

    result = cur.execute('select * from daily_data')
    rlist = list()
    for row in result:
        rlist.append(str(row))

    return rlist


if __name__ == "__main__":

    # Get an argument from Vim
    db_path = vim.eval("g:db_path")
    exe_type = vim.eval("s:exe_type")

    # Open
    conn = db_connect(db_path)

    # Execute and Return
    if exe_type == "get_table_list":
        rlist = getTableList(conn)

        vim.command('let s:result_select = "' + ",".join(rlist) + '"')

    elif exe_type == "select_all":
        rlist = selectAll(conn)

        vim.command('let s:result_select = "' + ",".join(rlist) + '"')

    # Close
    db_disconnect(conn)
