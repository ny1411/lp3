import heapq
import math

class Node:
    def __init__(self, char, freq):
        self.char = char
        self.freq = freq
        self.left = None
        self.right = None

    def __lt__(self, other):
        return self.freq < other.freq


def huffman_encode(text):
    freq = {}
    for ch in text:
        freq[ch] = freq.get(ch, 0) + 1

    heap = [Node(ch, f) for ch, f in freq.items()]
    heapq.heapify(heap)

    while len(heap) > 1:
        left = heapq.heappop(heap)
        right = heapq.heappop(heap)
        new_node = Node(None, left.freq + right.freq)
        new_node.left = left
        new_node.right = right
        heapq.heappush(heap, new_node)

    root = heap[0]
    codes = {}

    def generate_codes(node, code):
        if node.char is not None:
            codes[node.char] = code
            return
        generate_codes(node.left, code + "0")
        generate_codes(node.right, code + "1")

    generate_codes(root, "")
    return codes


text = input("Enter a string: ")

codes = huffman_encode(text)

print("\nHuffman Codes:")
for ch in codes:
    print(f"{repr(ch)} : {codes[ch]}")

# Encoded text
encoded_text = "".join(codes[ch] for ch in text)
print("\nEncoded Text:", encoded_text)

# Size calculations
original_bits = len(text) * 8
compressed_bits = len(encoded_text)
original_bytes = math.ceil(original_bits / 8)
compressed_bytes = math.ceil(compressed_bits / 8)

print("\n--- Size Comparison ---")
print(f"Characters in text: {len(text)}")
print(f"Original size: {original_bits} bits ({original_bytes} bytes)")
print(f"Compressed size: {compressed_bits} bits ({compressed_bytes} bytes)")
saving = original_bits - compressed_bits
print(f"Space saved: {saving} bits")
