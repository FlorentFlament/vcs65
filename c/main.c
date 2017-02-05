#include <atari2600.h>
#include "sync.h"
#include "kernal.h"

void main(void) {
  unsigned char color = 0;

  while(42) {
    // Inter-frame logic happens there
    color++;
    wait_overscan();
    // Display frame
    kernal(color);
  }
}
