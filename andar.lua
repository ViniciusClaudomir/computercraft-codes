-- Turtle que anda em linha detectando obsidiana abaixo
-- Baseado no conceito de robôs com sensor de luz

-- Função para detectar se o bloco abaixo é obsidiana
function detectarObsidiana()
    local sucesso, dados = turtle.inspectDown()
    if sucesso then
        -- Obsidiana tem o nome "minecraft:obsidian" no ComputerCraft
        return dados.name == "minecraft:obsidian"
    end
    return false
end

-- Função para reabastecer a turtle
function reabastecer()
    local nivelCombustivel = turtle.getFuelLevel()
    local maxCombustivel = turtle.getFuelLimit()
    
    print("Nível de combustível atual: " .. nivelCombustivel .. "/" .. maxCombustivel)
    
    -- Se o combustível estiver baixo (menos de 20% do máximo)
    if nivelCombustivel < (maxCombustivel * 0.2) then
        print("Combustível baixo! Tentando reabastecer...")
        
        -- Procura por combustível no inventário
        for i = 1, 16 do
            local item = turtle.getItemDetail(i)
            if item then
                -- Lista de itens combustíveis comuns
                local combustiveis = {
                    "minecraft:coal",
                    "minecraft:charcoal", 
                    "minecraft:lava_bucket",
                    "minecraft:blaze_rod",
                    "minecraft:coal_block",
                    "minecraft:charcoal_block",
                    "minecraft:oak_log",
                    "minecraft:spruce_log",
                    "minecraft:birch_log",
                    "minecraft:jungle_log",
                    "minecraft:acacia_log",
                    "minecraft:dark_oak_log",
                    "minecraft:oak_planks",
                    "minecraft:spruce_planks",
                    "minecraft:birch_planks",
                    "minecraft:jungle_planks",
                    "minecraft:acacia_planks",
                    "minecraft:dark_oak_planks",
                    "minecraft:oak_stairs",
                    "minecraft:spruce_stairs",
                    "minecraft:birch_stairs",
                    "minecraft:jungle_stairs",
                    "minecraft:acacia_stairs",
                    "minecraft:dark_oak_stairs",
                    "minecraft:oak_slab",
                    "minecraft:spruce_slab",
                    "minecraft:birch_slab",
                    "minecraft:jungle_slab",
                    "minecraft:acacia_slab",
                    "minecraft:dark_oak_slab",
                    "minecraft:oak_fence",
                    "minecraft:spruce_fence",
                    "minecraft:birch_fence",
                    "minecraft:jungle_fence",
                    "minecraft:acacia_fence",
                    "minecraft:dark_oak_fence",
                    "minecraft:oak_door",
                    "minecraft:spruce_door",
                    "minecraft:birch_door",
                    "minecraft:jungle_door",
                    "minecraft:acacia_door",
                    "minecraft:dark_oak_door",
                    "minecraft:oak_trapdoor",
                    "minecraft:spruce_trapdoor",
                    "minecraft:birch_trapdoor",
                    "minecraft:jungle_trapdoor",
                    "minecraft:acacia_trapdoor",
                    "minecraft:dark_oak_trapdoor",
                    "minecraft:oak_pressure_plate",
                    "minecraft:spruce_pressure_plate",
                    "minecraft:birch_pressure_plate",
                    "minecraft:jungle_pressure_plate",
                    "minecraft:acacia_pressure_plate",
                    "minecraft:dark_oak_pressure_plate",
                    "minecraft:oak_button",
                    "minecraft:spruce_button",
                    "minecraft:birch_button",
                    "minecraft:jungle_button",
                    "minecraft:acacia_button",
                    "minecraft:dark_oak_button",
                    "minecraft:oak_sign",
                    "minecraft:spruce_sign",
                    "minecraft:birch_sign",
                    "minecraft:jungle_sign",
                    "minecraft:acacia_sign",
                    "minecraft:dark_oak_sign",
                    "minecraft:oak_boat",
                    "minecraft:spruce_boat",
                    "minecraft:birch_boat",
                    "minecraft:jungle_boat",
                    "minecraft:acacia_boat",
                    "minecraft:dark_oak_boat",
                    "minecraft:oak_chest",
                    "minecraft:spruce_chest",
                    "minecraft:birch_chest",
                    "minecraft:jungle_chest",
                    "minecraft:acacia_chest",
                    "minecraft:dark_oak_chest",
                    "minecraft:oak_crafting_table",
                    "minecraft:spruce_crafting_table",
                    "minecraft:birch_crafting_table",
                    "minecraft:jungle_crafting_table",
                    "minecraft:acacia_crafting_table",
                    "minecraft:dark_oak_crafting_table",
                    "minecraft:oak_bed",
                    "minecraft:spruce_bed",
                    "minecraft:birch_bed",
                    "minecraft:jungle_bed",
                    "minecraft:acacia_bed",
                    "minecraft:dark_oak_bed",
                    "minecraft:oak_bookshelf",
                    "minecraft:spruce_bookshelf",
                    "minecraft:birch_bookshelf",
                    "minecraft:jungle_bookshelf",
                    "minecraft:acacia_bookshelf",
                    "minecraft:dark_oak_bookshelf",
                    "minecraft:oak_ladder",
                    "minecraft:spruce_ladder",
                    "minecraft:birch_ladder",
                    "minecraft:jungle_ladder",
                    "minecraft:acacia_ladder",
                    "minecraft:dark_oak_ladder",
                    "minecraft:oak_fence_gate",
                    "minecraft:spruce_fence_gate",
                    "minecraft:birch_fence_gate",
                    "minecraft:jungle_fence_gate",
                    "minecraft:acacia_fence_gate",
                    "minecraft:dark_oak_fence_gate",
                    "minecraft:oak_leaves",
                    "minecraft:spruce_leaves",
                    "minecraft:birch_leaves",
                    "minecraft:jungle_leaves",
                    "minecraft:acacia_leaves",
                    "minecraft:dark_oak_leaves",
                    "minecraft:oak_sapling",
                    "minecraft:spruce_sapling",
                    "minecraft:birch_sapling",
                    "minecraft:jungle_sapling",
                    "minecraft:acacia_sapling",
                    "minecraft:dark_oak_sapling",
                    "minecraft:oak_bark",
                    "minecraft:spruce_bark",
                    "minecraft:birch_bark",
                    "minecraft:jungle_bark",
                    "minecraft:acacia_bark",
                    "minecraft:dark_oak_bark",
                    "minecraft:oak_wood",
                    "minecraft:spruce_wood",
                    "minecraft:birch_wood",
                    "minecraft:jungle_wood",
                    "minecraft:acacia_wood",
                    "minecraft:dark_oak_wood",
                    "minecraft:oak_stripped_log",
                    "minecraft:spruce_stripped_log",
                    "minecraft:birch_stripped_log",
                    "minecraft:jungle_stripped_log",
                    "minecraft:acacia_stripped_log",
                    "minecraft:dark_oak_stripped_log",
                    "minecraft:oak_stripped_wood",
                    "minecraft:spruce_stripped_wood",
                    "minecraft:birch_stripped_wood",
                    "minecraft:jungle_stripped_wood",
                    "minecraft:acacia_stripped_wood",
                    "minecraft:dark_oak_stripped_wood"
                }
                
                for _, combustivel in ipairs(combustiveis) do
                    if item.name == combustivel then
                        turtle.select(i)
                        if turtle.refuel(1) then
                            print("Reabastecido com " .. item.name)
                            turtle.select(1) -- Volta para o slot 1
                            return true
                        end
                    end
                end
            end
        end
        
        print("AVISO: Nenhum combustível encontrado no inventário!")
        print("Coloque carvão, carvão vegetal, balde de lava, blaze rod ou madeira no inventário")
        return false
    end
    
    return true -- Combustível suficiente
end

-- Função principal para andar em linha
function andarEmLinha()
    print("Iniciando movimento em linha...")
    print("Pressione Ctrl+T para parar")
    
    while true do
        -- Verifica combustível antes de cada movimento
        if not reabastecer() then
            print("ERRO: Sem combustível! Parando movimento...")
            break
        end
        
        -- Verifica se há obsidiana abaixo
        if detectarObsidiana() then
            print("Obsidiana detectada! Movendo para frente...")
            -- Tenta mover para frente
            if turtle.forward() then
                print("Movimento realizado com sucesso")
            else
                print("Não foi possível mover para frente")
                -- Tenta quebrar o bloco à frente se não conseguir mover
                if turtle.detect() then
                    turtle.dig()
                    turtle.forward()
                end
            end
        else
            print("Obsidiana não detectada! Parando...")
            break
        end
        
        -- Pequena pausa para não sobrecarregar
        os.sleep(0.1)
    end
    
    print("Movimento finalizado")
end

-- Função para voltar ao ponto inicial
function voltarAoInicio()
    print("Voltando ao ponto inicial...")
    
    -- Verifica combustível antes de começar
    if not reabastecer() then
        print("ERRO: Sem combustível para voltar!")
        return
    end
    
    turtle.turnLeft()
    turtle.turnLeft()
    
    while detectarObsidiana() do
        -- Verifica combustível antes de cada movimento
        if not reabastecer() then
            print("ERRO: Sem combustível durante retorno!")
            break
        end
        
        turtle.forward()
        os.sleep(0.1)
    end
    
    turtle.turnLeft()
    turtle.turnLeft()
    print("Retorno concluído")
end

-- Menu principal
function menu()
    print("=== Turtle Seguidor de Obsidiana ===")
    print("1. Andar em linha")
    print("2. Voltar ao início")
    print("3. Testar detecção de obsidiana")
    print("4. Verificar combustível")
    print("5. Sair")
    print("Escolha uma opção:")
    
    local opcao = read()
    
    if opcao == "1" then
        andarEmLinha()
    elseif opcao == "2" then
        voltarAoInicio()
    elseif opcao == "3" then
        if detectarObsidiana() then
            print("Obsidiana detectada abaixo!")
        else
            print("Nenhuma obsidiana detectada abaixo")
        end
    elseif opcao == "4" then
        reabastecer()
    elseif opcao == "5" then
        print("Programa finalizado")
        return
    else
        print("Opção inválida!")
    end
    
    print()
    menu() -- Volta ao menu
end

-- Inicia o programa
print("Turtle Seguidor de Obsidiana carregado!")
menu()
