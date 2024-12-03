#!/bin/bash

# 日付と時間を処理する関数
process_date_time() {
    local date_line="$1"
    local time_line="$2"

    # 日付の処理
    IFS='/' read -r year month day_dow <<< "$date_line"
    day=${day_dow%%(*}
    dow=${day_dow#*(}
    dow=${dow%)}

    # 時間の処理
    IFS=' - ' read -r start_time end_time <<< "$time_line"

    # 先頭の0を除去
    month=$(echo "$month" | sed 's/^0*//')
    day=$(echo "$day" | sed 's/^0*//')

    echo "${month}/${day}(${dow}) ${start_time}-${end_time}"
}

# ユーザーへの指示を表示
echo "Spirの日付テキストを貼り付けてください。改行後、Ctrl+Dで完了します。"
echo

# 入力を配列に格納
mapfile -t input_array

# 結果表示の前半部分
echo
echo "以下をコピーしてください"
echo
echo "=========="
echo

# 配列を処理し、結果を直接表示
for ((i=0; i<${#input_array[@]}; i++)); do
    if [[ -n "${input_array[i]}" && "${input_array[i]}" == *"/"* ]]; then
        date_line="${input_array[i]}"
        time_line="${input_array[i+1]}"
        process_date_time "$date_line" "$time_line"
    fi
done

# 結果表示の後半部分
echo
echo "=========="
