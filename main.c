#include <stdio.h>
#include <stdint.h>
#include <stdlib.h>
#include <time.h>

uint32_t crc32_c(const uint8_t* data, uint32_t length);
uint32_t crc32_asm(__reg("a0") const uint8_t* data, __reg("d0") uint32_t length);

int main()
{
	time_t t = time(NULL);
	srand(t);

	const uint32_t numElements = 64 * 1024;
	uint32_t bufferSize = numElements * sizeof(uint16_t);

	uint16_t* buffer = (uint16_t*)malloc(bufferSize);

	for (uint32_t i = 0; i < numElements; ++i)
		buffer[i] = rand();

	printf("crc32_c   = %08lx\n", crc32_c  ((uint8_t*)buffer, bufferSize));
	printf("crc32_asm = %08lx\n", crc32_asm((uint8_t*)buffer, bufferSize));

	FILE* f = fopen("crc.bin", "wb");
	if (f)
	{
		fwrite(buffer, 1, bufferSize, f);
		fclose(f);
	}

	free(buffer);
	return 0;
}
