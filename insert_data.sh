#! /bin/bash

if [[ $1 == "test" ]]
then
  PSQL="psql --username=postgres --dbname=worldcuptest -t --no-align -c"
else
  PSQL="psql --username=freecodecamp --dbname=worldcup -t --no-align -c"
fi

# Do not change code above this line. Use the PSQL variable above to query your database.

$($PSQL "truncate teams, games")

cat games.csv | while IFS="," read year round winner opponent winner_goals opponent_goals

do
if [[ $year != "year" ]]
  then
  # get team id for the winner
  WINNER_ID=$($PSQL "select team_id from teams where name = '$winner'")

  # if not found
  if [[ -z $WINNER_ID ]]
  then
    # insert into teams
    INSERT_INTO_TEAMS_RESULT=$($PSQL "insert into teams(name) values ('$winner')")
    # get winner id after inserting
    WINNER_ID=$($PSQL "select team_id as winner_id from teams where name = '$winner'")
  fi

  # get team id for the opponent
  OPPONENT_ID=$($PSQL "select team_id from teams where name = '$opponent'")

  # if not found
  if [[ -z $TEAM_ID ]]
  then
    # insert into teams
    INSERT_INTO_TEAMS_RESULT=$($PSQL "insert into teams(name) values ('$opponent')")
    # get opponent id after inserting
    OPPONENT_ID=$($PSQL "select team_id as winner_id from teams where name = '$opponent'")
  fi

  # insert row into games
  INSERT_INTO_GAMES_RESULT=$($PSQL "insert into games(year, round, winner_id, opponent_id, winner_goals, opponent_goals) values ($year, '$round', $WINNER_ID, $OPPONENT_ID, $winner_goals, $opponent_goals)")
  
fi
done