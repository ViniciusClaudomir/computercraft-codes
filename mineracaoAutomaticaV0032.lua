local pos_chest = false
-- Função para detectar se o bloco abaixo é obsidiana
function detectarObsidianaAbaixo()
    local sucesso, dados = turtle.inspectDown()
    if sucesso then
        -- Obsidiana tem o nome "minecraft:obsidian" no ComputerCraft
        return dados.name == "minecraft:obsidian"
    end
    return false
end

-- Função para detectar se o bloco à frente é obsidiana
function detectarObsidianaFrente()
    local sucesso, dados = turtle.inspect()
    if sucesso then
        return dados.name == "minecraft:obsidian"
    end
    return false
end

function minerarObsidiana()
    while not verificarInventario() do
        if detectarObsidianaFrente() then
            turtle.dig()
            os.sleep(0.5)
            print("Obsidiana quebrada!")
        else
            print("Nenhuma obsidiana encontrada à frente")
            break
        end
    end
end

function verificarInventario()
    local inventarioCheio = true
    for i = 1, 16 do
        local item = turtle.getItemDetail(i)
        if not item then
            inventarioCheio = false
            break
        end
    end
    return inventarioCheio
end

function reabastecer()
    local nivelCombustivel = turtle.getFuelLevel()
    local maxCombustivel = turtle.getFuelLimit()
    print("Nível de combustível atual: " .. nivelCombustivel .. "/" .. maxCombustivel)
    
    if nivelCombustivel < 100 then
        print("Combustível baixo! Tentando reabastecer...")
        local item = turtle.getItemDetail(1)
        if item and turtle.refuel(1) then
            print("Combustível adicionado!")
            nivelCombustivel = turtle.getFuelLevel()
        else
            print("ERRO: Sem combustível no slot 1 para continuar!")
            return false
        end
    end
    return true
end

function depositAllObsidian()
    for slot = 1, 16 do
        turtle.select(slot)
        local item = turtle.getItemDetail()
        if item and item.name:find("obsidian") then
            turtle.drop()  -- dropa na frente
        end
    end
    turtle.select(1) -- retorna ao slot 1
end

function virar()
    if pos_chest then
        print("Vira esquerda")
        turtle.turnLeft()
    else
        print("Virar direita")
        turtle.turnRight()
    end
end

-- Função para verificar se o bloco abaixo é válido (obsidiana ou bloco de ferro)
function blocoValidoAbaixo()
    local sucesso, dados = turtle.inspectDown()
    if sucesso then
        return dados.name == "minecraft:obsidian" or dados.name == "minecraft:iron_block"
    end
    return false
end

function andarEmObsidiana(contador)
    -- Proteção contra loops infinitos
    contador = contador or 0
    if contador > 100 then
        print("ERRO: Muitas tentativas de movimento, parando...")
        return false
    end
    
    -- Verifica se o bloco abaixo é obsidiana ou bloco de ferro
    print("Posicao: ", pos_chest, " - Tentativa: ", contador)
    local sucesso, dados = turtle.inspectDown()

    if sucesso and (dados.name == "minecraft:obsidian" or dados.name == "minecraft:iron_block") then
        -- Se for bloco de ferro e ainda não depositou, deposita
        if dados.name == "minecraft:iron_block" and pos_chest == false then
            turtle.turnLeft()
            depositAllObsidian()
            pos_chest = true
            turtle.turnRight()
            turtle.forward()
            return andarEmObsidiana(contador + 1)
        end
        
        if turtle.forward() then
            print("Andando sobre bloco válido...")
            if blocoValidoAbaixo() then
                return andarEmObsidiana(contador + 1)
            end
        else
            print("Não conseguiu andar para frente")
            local sucesso2, dados2 = turtle.inspectDown()
            if sucesso2 and dados2.name == "minecraft:obsidian" then
                print("Obsidiana à frente!!!")
                return true
            end
        end
    else
        -- Se não for bloco válido, volta para o bloco anterior
        print("Bloco válido não encontrado, voltando...")
        turtle.back()

        -- Primeiro tenta virar na direção permitida
        virar()
        
        if blocoValidoAbaixo() then
            if turtle.forward() then
                print("Encontrou bloco válido na direção permitida, continuando...")
                return andarEmObsidiana(contador + 1)
            end
        else
            -- Se não encontrar, volta para a posição original
            if pos_chest then
                turtle.turnRight()  -- Desfaz turnLeft
            else
                turtle.turnLeft()   -- Desfaz turnRight
            end
            print("Nenhum bloco válido encontrado na direção permitida")
            return false
        end
    end
    return false
end

function voltarParaMineracao()
    -- Vira para sair do baú
    turtle.turnRight()
    turtle.turnRight()
    
    -- Volta pelo caminho de obsidiana
    while blocoValidoAbaixo() do
        if not turtle.forward() then
            break
        end
    end
    
    -- Ajusta posição para minerar novamente
    turtle.turnRight()
    turtle.turnRight()
    print("Voltou para a posição de mineração!")
end

-- Função principal
function main()
    print("Iniciando mineração automática de obsidiana...")
    
    while true do
        -- Minerar enquanto o inventário não estiver cheio
        while not verificarInventario() do
            -- Verificar combustível antes de minerar
            if not reabastecer() then
                print("Parando mineração devido à falta de combustível")
                return
            end
            
            -- Verificar se há combustível suficiente para minerar
            if turtle.getFuelLevel() < 1 then
                print("ERRO: Sem combustível para minerar!")
                return
            end
            
            minerarObsidiana()
        end

        -- Quando o inventário estiver cheio, vai para o baú
        print("Inventário cheio, indo para o baú...")
        turtle.turnLeft()
        turtle.turnLeft()
        turtle.forward()
        turtle.turnLeft()

        -- Caminha em direção ao baú seguindo a obsidiana
        local chegouAoBau = andarEmObsidiana()
        
        -- Se chegou ao baú com sucesso, volta para mineração
        if chegouAoBau then
            pos_chest = false
            print("Chegou ao baú! Voltando para mineração...")
            voltarParaMineracao()
        else
            print("Não conseguiu chegar ao baú, tentando novamente...")
            -- Pode implementar uma lógica de recuperação aqui
        end
    end
    
    print("Mineração concluída! Inventário cheio ou sem combustível.")
end

-- Executar o programa
main()