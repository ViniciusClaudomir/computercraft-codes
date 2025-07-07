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
    while nivelCombustivel < (maxCombustivel * 0.2) then
        print("Combustível baixo! Tentando reabastecer...")
        local item = turtle.getItemDetail(i)
        turtle.refuel(1)
    end

while not verificarInventario() do
    reabastecer()
    minerarObsidiana()