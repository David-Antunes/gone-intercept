# GONE-INTERCEPT

Repository containing a simple example of intercepting messages from GONE.

`example.sh` creates network topology with 3 routers, 5 bridges and 10 nodes. It will then proceed to intercept the network traffic of the first containerand apply specific traffic shaping, specifically a 10 millisecond delay.

To run the experiment, just execute `example.sh`.

```bash
example.sh
```

This script, builds the binary and the docker image and deploys the network topology.

To intercept the network traffic you will require `sudo` priviledges.
