// SPDX-License-Identifier: MIT

#include <stdint.h>

#define POLYNOMIAL 0xDB710641	// CRC-32/ISO-HDLC, CRC-32-IEEE

uint32_t crc32_c(const uint8_t* data, uint32_t length)
{
    uint32_t crc = 0xFFFFFFFF;
    while (length--)
    {
        crc ^= (*data++);
        for (int i = 0; i < 8; i++)
        {
            if (crc & 0x1)
            {
                crc ^= POLYNOMIAL;
                crc >>= 1;
                crc |= 0x80000000;
            }
            else
            {
                crc >>= 1;
            }
        }
   }
   return ~crc;
}
