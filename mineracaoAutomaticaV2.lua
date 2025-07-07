-- Função para detectar se o bloco abaixo é obsidiana
function detectarObsidiana()
    local sucesso, dados = turtle.inspectDown()
    if sucesso then
        -- Obsidiana tem o nome "minecraft:obsidian" no ComputerCraft
        return dados.name == "minecraft:obsidian"
    end
    return false
end

function minerarObsidiana()
    while not verificarInventario() do
        if detectarObsidiana() then
            turtle.digDown()
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

-- Função principal
function main()
    print("Iniciando mineração automática de obsidiana...")
    
    while not verificarInventario() do
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
    
    print("Mineração concluída! Inventário cheio ou sem combustível.")
end

-- Executar o programa
main()