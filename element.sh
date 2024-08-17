PSQL="psql --username=freecodecamp --dbname=periodic_table -t --no-align -c"


if [[ -z $1 ]]
then

  echo "Please provide an element as an argument."

else
  if [[ ! $1 =~ ^[0-9]+$ ]] 
  then
    #VERIFICATION $1
    FIND_ATOMIC_NUMBER=$($PSQL "SELECT atomic_number FROM elements WHERE symbol='$1' OR name='$1'")
    if [[ -z $FIND_ATOMIC_NUMBER ]]
    then
      echo -e "I could not find that element in the database."
    else
    FIND_ELEMENT=$($PSQL "SELECT * FROM elements INNER JOIN properties USING(atomic_number) INNER JOIN types USING(type_id) WHERE atomic_number=$FIND_ATOMIC_NUMBER")
    
    echo "$FIND_ELEMENT" | while IFS="|" read -r TYPE_ID ATOMIC_NUMBER SYMBOL ELEMENT ATOMIC_MASS MELTING BOILING TYPE
    do
      echo "The element with atomic number $FIND_ATOMIC_NUMBER is $ELEMENT ($SYMBOL). It's a $TYPE, with a mass of $ATOMIC_MASS amu. $ELEMENT has a melting point of $MELTING celsius and a boiling point of $BOILING celsius."
    done

    fi

  else
    if [[ $1 -gt 0 && $1 -lt 11 ]] 
    then
      FIND_ELEMENT=$($PSQL "SELECT * FROM elements INNER JOIN properties USING(atomic_number) INNER JOIN types USING(type_id) WHERE atomic_number=$1")

      echo "$FIND_ELEMENT" | while IFS="|" read -r TYPE_ID ATOMIC_NUMBER SYMBOL ELEMENT ATOMIC_MASS MELTING BOILING TYPE
      do
        echo "The element with atomic number $1 is $ELEMENT ($SYMBOL). It's a $TYPE, with a mass of $ATOMIC_MASS amu. $ELEMENT has a melting point of $MELTING celsius and a boiling point of $BOILING celsius."
      done
    else
      echo -e "I could not find that element in the database."
    fi
  fi
fi




