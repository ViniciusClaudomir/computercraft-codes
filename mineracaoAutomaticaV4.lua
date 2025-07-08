-- Função para detectar se o bloco abaixo é obsidiana
function detectarObsidiana()
    local sucesso, dados = turtle.inspect()
    if sucesso then
        -- Obsidiana tem o nome "minecraft:obsidian" no ComputerCraft
        return dados.name == "minecraft:obsidian"
    end
    return false
end

function minerarObsidiana()
    while not verificarInventario() do
        if detectarObsidiana() then
            turtle.dig()
            os.sleep(0.5)
            print("Obsidiana quebrada!")
        else
            print("Nenhuma obsidiana encontrada abaixo")
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
    
    if nivelCombustivel < (maxCombustivel * 0.2) then
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

function andarEmObsidiana()
    -- Verifica se o bloco abaixo é obsidiana
    local sucesso, dados = turtle.inspectDown()
    if sucesso and dados.name == "minecraft:obsidian" then
        -- Se for obsidiana, anda para frente
        if turtle.forward() then
            print("Andando sobre obsidiana...")
            if turtle.inspectLeft()[1] == "minecraft:chest" then
                turtle.turnLeft()
                depositAllObsidian()
                turtle.turnRight()

            end
            if turtle.inspectRight()[1] == "minecraft:chest" then
                turtle.turnRight()
                depositAllObsidian()
                turtle.turnLeft()
            end
            if turtle.inspect()[1] == "minecraft:obsidian" then
                return true
            end
            andarEmObsidiana()
        else
            print("Não conseguiu andar para frente")
        end
    else
        -- Se não for obsidiana, volta para o bloco anterior
        print("Obsidiana não encontrada, voltando...")
        turtle.back()
        
        -- Vira para a direita e verifica
        turtle.turnRight()
        local sucessoDir, dadosDir = turtle.inspectDown()
        if sucessoDir and dadosDir.name == "minecraft:obsidian" then
            if turtle.forward() then
                print("Encontrou obsidiana à direita, continuando...")
                andarEmObsidiana()
            end
        else
            -- Se não encontrar à direita, vira para a esquerda e verifica
            turtle.turnLeft()
            turtle.turnLeft()
            local sucessoEsq, dadosEsq = turtle.inspectDown()
            if sucessoEsq and dadosEsq.name == "minecraft:obsidian" then
                if turtle.forward() then
                    print("Encontrou obsidiana à esquerda, continuando...")
                    andarEmObsidiana()
                end
            else
                -- Se não encontrar em nenhum lado, volta para a posição original
                turtle.turnRight()
                print("Nenhuma obsidiana encontrada em nenhuma direção")
            end
        end
    end
end


-- Função principal
function main()
    print("Iniciando mineração automática de obsidiana...")
    
    while true do
        -- Verificar combustível antes de minerar
        if not reabastecer() then
            print("Parando mineração devido à falta de combustível")
            break
        end
        
        -- Verificar se há combustível suficiente para minerar
        if turtle.getFuelLevel() < 1 then
            print("ERRO: Sem combustível para minerar!")
            break
        end
        
        minerarObsidiana()
    end
    

    andarEmObsidiana()
    
    print("Mineração concluída! Inventário cheio ou sem combustível.")
end



-- Executar o programa
main()