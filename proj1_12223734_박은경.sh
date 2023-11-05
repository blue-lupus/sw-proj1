#!/bin/bash

u.item="$1"
u.data="$2"
u.user="$3"

get_movie_data() {
read -p "Please enter the 'movie id'(1~1682) : " m_id

if [[ $m_id -ge 1 && $m_id -le 1682 ]]; then
movie_data=$(awk -F'|' -v movie_id ="$m_id" '$1 == movie_id {print}' "$item")

if [ -n "$movie_data" ]; then
echo "$movie_data"

else
echo "$m_id is not found."
fi

else
echo "Movie id should be between 1 and 1682."
fi
}

get_action_genre_movies() {
read -p "Do you want to get the data of 'action' genre movies from 'u.item'? (y/n): " answer

if [ "$answer" == "y" ]; then
action_movies_data=$(awk -F'|' '$6 ~ /Action/ {print $1, $2}' "$u.item" | sort -n | head -n 10 | awk '{print $1, $2}')

if [ -n "$action_movies_data" ]; then
echo "$action_movies_data"

fi

fi
}


get_average_rating() {
read -p "Please enter the 'movie id'(1~1682) : " m_id

if [[ $m_id -ge 1 && $m_id -le 1682 ]]; then
average =$(awk -F'\t' -v movie_id="$m_id" '$2 == movie_id {sum += $3; count++} END {printf "%.5f", sum / count }' "$u.data")

if[ -n "$average" ]; then
echo "average rationg of $m_id: $average"

else
echo "No rating"
fi

else
echo "Movie id should be between 1 and 1682."
fi

}


delete_imdb_url() {
read -p "Do you want to delete the 'IMDb URL' from 'u.item'?(y/n) " answer

if["$answer" == "y"]; then
sed 's|http://[^|]*||g' "$u.item" | head -n 10
fi


get_user_data() {
read -p "Do you want to get the data about users from 'u.user'?(y/n): " answer

if["$answer" == "y"]; then
sed -n '1,10p' "$u.user" |awk -F'|' '{printf "user %d is %d years old %s %s \n", $1, $2, $3, $4 }'

fi
}


modify_release_date() {
read -p "Do you wanr ro Modify the format of 'release data' in 'u.item'?(y/n): " answer

if["$answer"=="y"];then
sed -n '1673,1682p' "$u.item" | awk -F'|' '{split($3, date_parts, "-");
release_date = date_parts[3] date_parts[2] date_parts[1];
printf "%d|%s|%s||%s|", $1, $2, release_date, $4;
for (i = 5; i <=NF; i++) {
printf "%s|", $i;
}
print "";
}'

fi

}


get_movies_rated_by_user() {
read -p "Please enter the 'user id' (1~943) : " u_id
}

get_average_rating_by_age_and_occupation() {
}

echo "----------------------------------"
echo "User Name : Park Eungyeong"
echo "Student Number : 12223734"
echo " [ MENU ] "
echo "1. Get the data of the movie identified by a specific 'movie id' from 'u.item' "
echo "2. Get the data of ‘action’ genre movies from'u.item’"
echo "3. Get the average 'rating’ of the movie identified by specific 'movie id' from 'u.data’"
echo "4. Delete the ‘IMDb URL’ from ‘u.item’"
echo "5. Get the data about users from 'u.user’ "
echo "6. Modify the format of 'release date' in 'u.item’ "
echo "7. Get the data of movies rated by a specific 'user id' from 'u.data' "
echo "8. Get the average 'rating' of movies rated by users with 'age' between 20 and 29 and 'occupation' as 'programmer' "
echo "9. Exit"
echo "------------------------------------"
while true; do
read " Enter your choice [ 1-9 ] " choice1

case $choice1 in
1)
get_movie_data
;;

2)
get_action_genre_movies
;;

3)
get_average_rating
;;

4)
delete_imdb_url
;;

5)
get_user_data
;;

6)
modify_release_data
;;

7)
get_movies_rated_by_user
;;

8)
get_average_rating_by_age_and_occupation
;;

9)
echo "Bye!"
exit 0
;;

*)
echo "Please enter a valid option."
;;

esac
done
