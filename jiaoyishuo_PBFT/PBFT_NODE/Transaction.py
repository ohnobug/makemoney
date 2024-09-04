import hashlib
import time
import ecdsa

class Transaction:
    def __init__(self):
        self.inputs = []
        self.outputs = []
        self.timestamp = time.time()
        self.hash = self.calculate_hash()

    def add_input(self, previous_tx_id, output_index, signature):
        self.inputs.append({
            'previous_tx_id': previous_tx_id,
            'output_index': output_index,
            'signature': signature
        })

    def add_output(self, recipient_address, amount):
        self.outputs.append({
            'recipient_address': recipient_address,
            'amount': amount
        })

    def calculate_hash(self):
        serialized_data = self.serialize()
        return hashlib.sha256(serialized_data.encode()).hexdigest()

    def serialize(self):
        serialized_inputs = "".join([f"{i['previous_tx_id']}{i['output_index']}{i['signature']}" for i in self.inputs])
        serialized_outputs = "".join([f"{o['recipient_address']}{o['amount']}" for o in self.outputs])
        return f"{serialized_inputs}{serialized_outputs}{self.timestamp}"

    def sign_transaction(self, private_key):
        sk = ecdsa.SigningKey.from_string(bytes.fromhex(private_key), curve=ecdsa.SECP256k1)
        message = self.serialize().encode()
        signature = sk.sign(message)
        for input_tx in self.inputs:
            input_tx['signature'] = signature.hex()
        self.hash = self.calculate_hash()
