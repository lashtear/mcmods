ulimit -c unlimited
export PATH_TO_JDK=/usr/lib/jvm/java-8-openjdk-amd64
java -Djava.library.path=$PATH_TO_JDK/jre/bin -cp $PATH_TO_JDK/lib/tools.jar:warmroast-1.0.0-SNAPSHOT.jar com.sk89q.warmroast.WarmRoast -m $HOME/mcp940/conf --bind 127.0.0.1

#--thread "Server thread"
