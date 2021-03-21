# require pip install BeautifulSoup4,requests

import vim
import sqlite3
import requests
from bs4 import BeautifulSoup


def get_response_content(url: str):

    # Get request from url top page.
    response = requests.get(url)

    # Get body content
    content = response.text.encode("utf-8")

    return content


def scrap_daily_data(content: str):

    # Create object.
    soup = BeautifulSoup(content, "lxml")
    table_tag = soup.find(class_="tjCjeiMn _1aNPcH77")
    tbody_tag = table_tag.find("tbody")
    tr_tags = tbody_tag.find_all("tr")

    data_list = list()
    for tr_tag in tr_tags:

        one_data_list = list()

        one_data_list.append(tr_tag.find("th").string)

        td_tags = tr_tag.find_all("td")
        for td_tag in td_tags:
            one_data_list.append(td_tag.string.replace(",", ""))

        data_list.append(one_data_list)

    return data_list


def insert_data(sqlite3_path: str, stock_code: str, data_list: list):

    # Open
    conn = sqlite3.connect(sqlite3_path)
    cur = conn.cursor()

    for data in data_list:

        sql = ""
        sql = "insert into daily_data values({},{},{},{},{},{},{},{})".format(
                "'" + stock_code + "'",
                "'" + data[0] + "'",
                data[1],
                data[2],
                data[3],
                data[4],
                data[5],
                data[6])

        try:
            # Insert
            cur.execute(sql)

        except sqlite3.IntegrityError:
            print("UNIQUE constrainnt failed! "
                  "StockCode:{}, TradeData:{}".format(stock_code, data[0]))

    # Commit
    conn.commit()
    print("Commit!")

    # Close
    conn.close()


if __name__ == "__main__":

    # Make url
    stock_code = vim.eval("s:stock_code")
    url = "https://finance.yahoo.co.jp/quote/" + stock_code + ".T/history"

    # Get daily data
    content = get_response_content(url)
    data_list = scrap_daily_data(content)

    # Insert to Sqlite3 database
    sqlite3_path = vim.eval("s:sqlite3_path")
    insert_data(sqlite3_path, stock_code, data_list)
