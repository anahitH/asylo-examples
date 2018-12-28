# asylo-examples
Simple applications partitioned with asylo

This repository contains applications partitioned into a security sensitive and normal parts. Security sensitive partitions are running on secure hardware using Asylo framework.
To pull docker image where asylo runs:

``` 

snake-asylo
--------------------------------------
Is a micro snake game from [https://github.com/troglobit/snake] with a simple partitioning into a security sensitive and normal partitions.
Security sensitive partition includes ```eat_gold``` function. Security sensitive partition needs to be extended by adding more functions.
To execute the game run following command from the ```snake-asylo``` directory.

```bazel run --config=enc-sim //snake-asylo:snake```
