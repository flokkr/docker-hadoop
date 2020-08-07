
wget http://norvig.com/big.txt -O /tmp/big.txt
EXAMPLEJAR=$(find -name "*example*.jar" | grep -v source)
hdfs dfs -copyFromLocal /tmp/big.txt /
yarn jar $EXAMPLEJAR pi 10 10 
yarn jar $EXAMPLEJAR wordcount /big.txt /wordcount
hdfs dfs -cat /wordcount/part-r-00000 | head
