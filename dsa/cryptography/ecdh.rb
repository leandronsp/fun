# Função de multiplicação de ponto em uma curva elíptica
def ec_multiply(point, scalar, a, p)
  return [nil, nil] if scalar % p == 0
  n = point
  result = [nil, nil]
  while scalar > 0
    result = ec_add(result, n, a, p) if scalar & 1 == 1
    n = ec_add(n, n, a, p)
    scalar >>= 1
  end
  result
end

# Função de soma de pontos em uma curva elíptica
def ec_add(point1, point2, a, p)
  return point2 if point1[0].nil?
  return point1 if point2[0].nil?
  x1, y1 = point1
  x2, y2 = point2
  if x1 == x2 && y1 != y2
    return [nil, nil]
  end
  if x1 == x2
    m = (3 * x1 * x1 + a) * mod_inverse(2 * y1, p) % p
  else
    m = (y1 - y2) * mod_inverse(x1 - x2, p) % p
  end
  x3 = (m * m - x1 - x2) % p
  y3 = (m * (x1 - x3) - y1) % p
  [x3, y3]
end

# Função para encontrar o inverso modular
def mod_inverse(number, modulus)
  g, x, y = extended_gcd(number, modulus)
  raise "O número não tem inverso modular" if g != 1
  x % modulus
end

# Algoritmo de Euclides estendido para encontrar o inverso modular
def extended_gcd(a, b)
  last_remainder, remainder = a.abs, b.abs
  x, last_x, y, last_y = 0, 1, 1, 0
  while remainder != 0
    last_remainder, (quotient, remainder) = remainder, last_remainder.divmod(remainder)
    x, last_x = last_x - quotient * x, x
    y, last_y = last_y - quotient * y, y
  end
  [last_remainder, last_x * (a < 0 ? -1 : 1), last_y * (b < 0 ? -1 : 1)]
end

# Parâmetros da curva elíptica
a = 2
b = 2
p = 17

# Ponto base (gerador) na curva elíptica
base_point = [5, 1]

# Chave privada do remetente
private_key_sender = 7

# Chave privada do destinatário
private_key_receiver = 13

# Geração da chave pública do remetente
public_key_sender = ec_multiply(base_point, private_key_sender, a, p)

# Geração da chave pública do destinatário
public_key_receiver = ec_multiply(base_point, private_key_receiver, a, p)

# Troca das chaves públicas

# Cálculo da chave compartilhada no lado do remetente
shared_key_sender = ec_multiply(public_key_receiver, private_key_sender, a, p)

# Cálculo da chave compartilhada no lado do destinatário
shared_key_receiver = ec_multiply(public_key_sender, private_key_receiver, a, p)

# Verificação se as chaves compartilhadas são iguais (chave compartilhada estabelecida com sucesso)
if shared_key_sender == shared_key_receiver
  puts "Chave compartilhada estabelecida com sucesso: #{shared_key_sender}"
else
  puts "Erro na troca de chaves públicas. Chaves compartilhadas diferentes."
end
