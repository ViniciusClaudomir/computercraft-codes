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
    if pos_chest == true then
        turtle.turnLeft()
    else
        turtle.turnRight()
    end
end

function andar()
    if not turtle.forward() then
        local sucesso0, dados0 = turtle.inspectDown()
        if  (dados.name ~= "minecraft:obsidian" and dados.name ~= "minecraft:iron_block") then
            turtle.back()
        end
        virar()
        return andar()
    else
        local sucesso, dados = turtle.inspectDown()
        if  (dados.name ~= "minecraft:obsidian" and dados.name ~= "minecraft:iron_block") then
            turtle.back()
            virar()
            return andar()
        end

        if dados.name == "minecraft:iron_block" and pos_chest == false then
            turtle.turnLeft()
            depositAllObsidian()
            turtle.turnLeft()
            pos_chest = true
            return andar()
        end
        
        sucesso2, dados2 = turtle.inspect()
        if sucesso2 and (dados2.name == "minecraft:obsidian") then
            if dados2.name == "minecraft:obsidian" then
                print("Encontrei obisidian pra minerar :D")
                return "minerar"
            end
        
        else
            return andar()
        end
    end
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
        
        turtle.back()
        turtle.turnLeft()
        pos_chest = false
        andar()

        
    end
    
    print("Mineração concluída! Inventário cheio ou sem combustível.")
end

-- Executar o programa
main()