# def encrypt(message):
#     cipher = ''
#     for char in message:
#         if char.isalpha():
#             # Shift character by 7 positions
#             char_code = ord(char) + 7
#             if char.isupper():
#                 if char_code > ord('Z'):
#                     char_code -= 26
#                 elif char_code < ord('A'):
#                     char_code += 26
#             else:
#                 if char_code > ord('z'):
#                     char_code -= 26
#                 elif char_code < ord('a'):
#                     char_code += 26
#             cipher += chr(char_code)
#         else:
#             cipher += char
#     return cipher


substitution_table = {
    'A': 'Y', 'B': 'y', 'C': 'm', 'D': 'Q', 'E': '4', 'F': 'E', 'G': 'J', 'H': 'p', 'I': 'X', 'J': 'O', 'K': 'o', 'L': 'n', 'M': 'b', 'N': 'U', 'O': 'C',
    'P': '.', 'Q': '9', 'R': 'N', 'S': 'a', 'T': 'v', 'U': 'h', 'V': 'k', 'W': 'K', 'X': '6', 'Y': 'x', 'Z': 'H', 'a': 'B', 'b': 'f', 'c': 'P', 'd': ' ',
    'e': '1', 'f': '8', 'g': 'W', 'h': 'M', 'i': 'j', 'j': 'D', 'k': 'Z', 'l': 'A', 'm': 'L', 'n': 'u', 'o': 'V', 'p': '3', 'q': 's', 'r': 'i', 's': 'q',
    't': ',', 'u': 't', 'v': 'd', 'w': 'e', 'x': 'g', 'y': 'F', 'z': '5', '0': 'R', '1': '0', '2': 'c', '3': 'I', '4': '7', '5': 'S', '6': 'G', '7': 'w',
    '8': 'T', '9': 'z', ' ': '2', ',': 'l', '.': 'r'
}

substitution_table = {'Y': 'A', 'y': 'B', 'm': 'C', 'Q': 'D', '4': 'E', 'E': 'F', 'J': 'G', 'p': 'H', 'X': 'I', 'O': 'J', 'o': 'K', 'n': 'L', 'b': 'M', 'U': 'N', 'C': 'O', '.': 'P', '9': 'Q', 'N': 'R', 'a': 'S', 'v': 'T', 'h': 'U', 'k': 'V', 'K': 'W', '6': 'X', 'x': 'Y', 'H': 'Z', 'B': 'a', 'f': 'b', 'P': 'c', ' ': 'd', '1': 'e', '8': 'f', 'W': 'g', 'M': 'h', 'j': 'i', 'D': 'j', 'Z': 'k', 'A': 'l', 'L': 'm', 'u': 'n', 'V': 'o', '3': 'p', 's': 'q', 'i': 'r', 'q': 's', ',': 't', 't': 'u', 'd': 'v', 'e': 'w', 'g': 'x', 'F': 'y', '5': 'z', 'R': '0', '0': '1', 'c': '2', 'I': '3', '7': '4', 'S': '5', 'G': '6', 'w': '7', 'T': '8', 'z': '9', '2': ' ', 'l': ',', 'r': '.'}


def encrypt(key, message):
    alpha = ' !"#$%&\'()*+,-./0123456789:;<=>?@ABCDEFGHIJKLMNOPQRSTUVWXYZ[\\]^_`abcdefghijklmnopqrstuvwxyz{|}~'
    result = ""

    for letter in message:
        if letter in alpha: #if the letter is actually a letter
            #find the corresponding ciphertext letter in the alphabet
            letter_index = (alpha.find(letter) + key) % len(alpha)

            result = result + alpha[letter_index]
        else:
            result = result + letter

    return result

def decrypt(key, message):
    alpha = ' !"#$%&\'()*+,-./0123456789:;<=>?@ABCDEFGHIJKLMNOPQRSTUVWXYZ[\\]^_`abcdefghijklmnopqrstuvwxyz{|}~'
    result = ""

    for letter in message:
        if letter in alpha: #if the letter is actually a letter
            #find the corresponding ciphertext letter in the alphabet
            letter_index = (alpha.find(letter) - key) % len(alpha)

            result = result + alpha[letter_index]
        else:
            result = result + letter

    return result



# def decrypt(text):
#     text = ''
#     for i in text:
#         print(i)
#         text+=substitution_table[i]
#     return(text)


# print(decrypt("Yt,2Pt3j j,B,123BijB,ti2juPj tu,2i1itLr"))