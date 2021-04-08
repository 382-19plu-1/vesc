# about start2NodeExample.launch
By default,
- `vesc_node0` will use port `/dev/ttyACM0`
- `vesc_node1` will use port `/dev/ttyACM1`
```shell
roslaunch vesc_driver start2NodeExample.launch 
```

To change to other port
```shell
roslaunch vesc_driver start2NodeExample.launch port0:=$port0path port1:=$port0path
```
### p.s. if the user is not in the dialout group,
add the user into the dialout group, and re-login
```shell
sudo usermod -a -G dialout $USER;
```
or do this every single times you connect to the USB
```shell
sudo chmod 666 /dev/theUSBPortName;
```
