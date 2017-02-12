#include <stdio.h>

#include "mbedtls/aes.h"
#include "mbedtls/gcm.h"

int main()
{
    unsigned char key[32];
    unsigned char iv[16];

    unsigned char plaintext[128];
    unsigned char ciphertext[128];
    unsigned char plaintext_result[128];

    size_t input_len = 40;
    size_t output_len = 0;

    memset(plaintext, 0, sizeof(unsigned char));
    memset(plaintext_result, 0, sizeof(unsigned char));

    for(int i=0; i< 40; ++i)
    {
        if(i < 32)
        {
            key[i] = i;
        }

        if(i < 16)
        {
            iv[i] = i;
        }

        plaintext[i] = i;
        plaintext_result[i] = -1;
    }

    printf("Plaintext: ");
    for(int i=0; i<40; i++)
    {
        printf("%x ", plaintext[i]);
    }

    mbedtls_aes_context aes;
    
    unsigned char tag[16];
    mbedtls_gcm_context ctx;
    mbedtls_gcm_init(&ctx);
    mbedtls_gcm_setkey(&ctx, MBEDTLS_CIPHER_ID_AES, key, 256);
    mbedtls_gcm_crypt_and_tag(&ctx, MBEDTLS_GCM_ENCRYPT, 40, iv, 16, NULL, 0, plaintext, ciphertext, 16, tag);

    printf("\nCiphertext: ");
    for(int i=0; i<40; i++)
    {
        printf("%x ", ciphertext[i]);
    }

    for(int i=0; i<16; i++)
    {
        iv[i] = i;
    }

    printf("\nTag: ");
    for(int i=0; i<16; i++)
    {
        printf("%x ", tag[i]);
    }

    mbedtls_gcm_auth_decrypt(&ctx, 40, iv, 16, NULL, 0, tag, 16, ciphertext, plaintext_result);
    mbedtls_gcm_free(&ctx);
    mbedtls_aes_free(&aes);
    printf("\nPlaintext result: ");
    for(int i=0; i<40; i++)
    {
        printf("%x ", plaintext_result[i]);
    }
}
