<?php
echo "<hr>";
echo "Vagrant Virtual Box Website Root";

$redis = new \Redis();
try {
    $redis->connect('localhost', 6379);
    echo "<h4 style='color:green;'> REDIS is Active</h4>";
} catch (\Exception $e) {
    var_dump($e->getMessage())  ;
}
echo "<hr>";

phpinfo();
