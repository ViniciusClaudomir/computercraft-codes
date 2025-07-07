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

-- Função para verificar se há obsidiana em uma direção específica
function verificarObsidianaDirecao(direcao)
    if direcao == "frente" then
        local sucesso, dados = turtle.inspect()
        if sucesso then
            return dados.name == "minecraft:obsidian"
        end
    elseif direcao == "esquerda" then
        turtle.turnLeft()
        local sucesso, dados = turtle.inspect()
        turtle.turnRight()
        if sucesso then
            return dados.name == "minecraft:obsidian"
        end
    elseif direcao == "direita" then
        turtle.turnRight()
        local sucesso, dados = turtle.inspect()
        turtle.turnLeft()
        if sucesso then
            return dados.name == "minecraft:obsidian"
        end
    end
    return false
end

-- Função para verificar se há um baú em uma direção específica
function verificarBauDirecao(direcao)
    if direcao == "esquerda" then
        turtle.turnLeft()
        local sucesso, dados = turtle.inspect()
        turtle.turnRight()
        if sucesso then
            return dados.name == "minecraft:chest"
        end
    elseif direcao == "direita" then
        turtle.turnRight()
        local sucesso, dados = turtle.inspect()
        turtle.turnLeft()
        if sucesso then
            return dados.name == "minecraft:chest"
        end
    end
    return false
end

-- Função para verificar se o inventário está cheio
function inventarioCheio()
    for i = 1, 16 do
        local item = turtle.getItemDetail(i)
        if not item then
            return false -- Encontrou um slot vazio
        end
    end
    return true -- Todos os slots estão ocupados
end

-- Função para contar quantas obsidianas tem no inventário
function contarObsidianas()
    local contador = 0
    for i = 1, 16 do
        local item = turtle.getItemDetail(i)
        if item and item.name == "minecraft:obsidian" then
            contador = contador + item.count
        end
    end
    return contador
end

-- Função para depositar obsidianas em um baú
function depositarObsidianas()
    print("Procurando baú para depositar obsidianas...")
    
    -- Verifica se há baú à esquerda ou direita
    local bauEsquerda = verificarBauDirecao("esquerda")
    local bauDireita = verificarBauDirecao("direita")
    
    if bauEsquerda then
        print("Baú encontrado à esquerda! Depositando...")
        turtle.turnLeft()
        turtle.place()
        turtle.turnRight()
        
        -- Deposita todas as obsidianas
        for i = 1, 16 do
            local item = turtle.getItemDetail(i)
            if item and item.name == "minecraft:obsidian" then
                turtle.select(i)
                turtle.drop()
            end
        end
        turtle.select(1) -- Volta para o slot 1
        print("Obsidianas depositadas com sucesso!")
        return true
        
    elseif bauDireita then
        print("Baú encontrado à direita! Depositando...")
        turtle.turnRight()
        turtle.place()
        turtle.turnLeft()
        
        -- Deposita todas as obsidianas
        for i = 1, 16 do
            local item = turtle.getItemDetail(i)
            if item and item.name == "minecraft:obsidian" then
                turtle.select(i)
                turtle.drop()
            end
        end
        turtle.select(1) -- Volta para o slot 1
        print("Obsidianas depositadas com sucesso!")
        return true
        
    else
        print("Nenhum baú encontrado nas laterais!")
        return false
    end
end

-- Função para procurar obsidiana na frente
function procurarObsidianaFrente()
    print("Procurando obsidiana na frente...")
    
    -- Anda pelo caminho de obsidiana abaixo até encontrar obsidiana na frente
    while detectarObsidiana() do
        -- Verifica se há obsidiana na frente
        if verificarObsidianaDirecao("frente") then
            print("Obsidiana encontrada na frente!")
            return true
        end
        
        -- Se não há obsidiana na frente, verifica as laterais
        local obsidianEsquerda = verificarObsidianaDirecao("esquerda")
        local obsidianDireita = verificarObsidianaDirecao("direita")
        
        if obsidianEsquerda then
            print("Virando para esquerda para procurar obsidiana...")
            turtle.turnLeft()
            turtle.forward()
        elseif obsidianDireita then
            print("Virando para direita para procurar obsidiana...")
            turtle.turnRight()
            turtle.forward()
        else
            print("Nenhuma obsidiana encontrada! Parando busca...")
            return false
        end
        
        os.sleep(0.1)
    end
    
    print("Não há mais obsidiana abaixo! Parando busca...")
    return false
end

-- Função para quebrar obsidiana até encher o inventário
function quebrarObsidianaAteEncher()
    print("Iniciando quebra de obsidiana até encher inventário...")
    
    while not inventarioCheio() do
        -- Verifica combustível
        if not reabastecer() then
            print("ERRO: Sem combustível! Parando quebra...")
            return false
        end
        
        -- Verifica se há obsidiana na frente
        if verificarObsidianaDirecao("frente") then
            print("Quebrando obsidiana na frente...")
            turtle.dig()
            print("Obsidiana quebrada! Total no inventário: " .. contarObsidianas())
        else
            print("Nenhuma obsidiana na frente! Procurando mais...")
            if not procurarObsidianaFrente() then
                print("Nenhuma obsidiana encontrada! Parando quebra...")
                return false
            end
        end
        
        os.sleep(0.1)
    end
    
    print("Inventário cheio! (" .. contarObsidianas() .. " obsidianas)")
    return true
end

-- Função principal de mineração automática de obsidiana
function minerarObsidiana()
    print("=== MINERAÇÃO AUTOMÁTICA DE OBSIDIANA ===")
    print("A turtle irá:")
    print("- Quebrar obsidiana até encher o inventário")
    print("- Depositar no baú quando estiver cheio")
    print("- Voltar a procurar mais obsidiana")
    print("Pressione Ctrl+T para parar")
    print()
    
    while true do
        -- Verifica combustível antes de cada ciclo
        if not reabastecer() then
            print("ERRO: Sem combustível! Parando mineração...")
            break
        end
        
        -- FASE 1: Quebrar obsidiana até encher o inventário
        print("=== FASE 1: QUEBRANDO OBSIDIANA ===")
        if not quebrarObsidianaAteEncher() then
            print("ERRO: Não foi possível quebrar obsidiana! Parando...")
            break
        end
        
        -- FASE 2: Depositar no baú
        print("=== FASE 2: DEPOSITANDO NO BAÚ ===")
        if not depositarObsidianas() then
            print("ERRO: Não foi possível depositar obsidianas! Parando...")
            break
        end
        
        print("=== CICLO COMPLETO! INICIANDO PRÓXIMO CICLO ===")
        print()
    end
    
    print("Mineração finalizada!")
end

-- Função para voltar ao ponto inicial com curvas
function voltarAoInicio()
    print("Voltando ao ponto inicial com curvas...")
    
    -- Verifica combustível antes de começar
    if not reabastecer() then
        print("ERRO: Sem combustível para voltar!")
        return
    end
    
    -- Vira 180 graus para voltar
    turtle.turnLeft()
    turtle.turnLeft()
    
    while detectarObsidiana() do
        -- Verifica combustível antes de cada movimento
        if not reabastecer() then
            print("ERRO: Sem combustível durante retorno!")
            break
        end
        
        -- Tenta mover para frente primeiro
        if turtle.forward() then
            print("Retorno: movimento para frente realizado")
        else
            -- Se não consegue ir para frente, verifica as laterais
            print("Retorno: verificando laterais...")
            
            local obsidianEsquerda = verificarObsidianaDirecao("esquerda")
            local obsidianDireita = verificarObsidianaDirecao("direita")
            
            if obsidianEsquerda then
                print("Retorno: obsidiana à esquerda! Virando...")
                turtle.turnLeft()
                if turtle.forward() then
                    print("Retorno: movimento para esquerda realizado")
                else
                    if turtle.detect() then
                        turtle.dig()
                        turtle.forward()
                    end
                end
            elseif obsidianDireita then
                print("Retorno: obsidiana à direita! Virando...")
                turtle.turnRight()
                if turtle.forward() then
                    print("Retorno: movimento para direita realizado")
                else
                    if turtle.detect() then
                        turtle.dig()
                        turtle.forward()
                    end
                end
            else
                print("Retorno: nenhuma obsidiana encontrada nas laterais! Parando...")
                break
            end
        end
        
        os.sleep(0.1)
    end
    
    -- Vira 180 graus para voltar à direção original
    turtle.turnLeft()
    turtle.turnLeft()
    print("Retorno concluído")
end

-- Menu principal
function menu()
    print("=== Turtle Mineradora de Obsidiana ===")
    print("1. Mineração automática de obsidiana")
    print("2. Voltar ao início")
    print("3. Testar detecção de obsidiana")
    print("4. Verificar combustível")
    print("5. Testar detecção lateral")
    print("6. Verificar inventário")
    print("7. Testar detecção de baú")
    print("8. Testar quebra até encher")
    print("9. Sair")
    print("Escolha uma opção:")
    
    local opcao = read()
    
    if opcao == "1" then
        minerarObsidiana()
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
        print("Testando detecção lateral...")
        local obsidianEsquerda = verificarObsidianaDirecao("esquerda")
        local obsidianDireita = verificarObsidianaDirecao("direita")
        local obsidianFrente = verificarObsidianaDirecao("frente")
        
        print("Obsidiana à frente: " .. (obsidianFrente and "SIM" or "NÃO"))
        print("Obsidiana à esquerda: " .. (obsidianEsquerda and "SIM" or "NÃO"))
        print("Obsidiana à direita: " .. (obsidianDireita and "SIM" or "NÃO"))
    elseif opcao == "6" then
        print("=== STATUS DO INVENTÁRIO ===")
        print("Inventário cheio: " .. (inventarioCheio() and "SIM" or "NÃO"))
        print("Obsidianas no inventário: " .. contarObsidianas())
        print("Slots ocupados:")
        for i = 1, 16 do
            local item = turtle.getItemDetail(i)
            if item then
                print("  Slot " .. i .. ": " .. item.name .. " x" .. item.count)
            end
        end
    elseif opcao == "7" then
        print("Testando detecção de baú...")
        local bauEsquerda = verificarBauDirecao("esquerda")
        local bauDireita = verificarBauDirecao("direita")
        
        print("Baú à esquerda: " .. (bauEsquerda and "SIM" or "NÃO"))
        print("Baú à direita: " .. (bauDireita and "SIM" or "NÃO"))
    elseif opcao == "8" then
        print("Testando quebra de obsidiana até encher...")
        if quebrarObsidianaAteEncher() then
            print("Teste concluído! Inventário cheio.")
        else
            print("Teste falhou!")
        end
    elseif opcao == "9" then
        print("Programa finalizado")
        return
    else
        print("Opção inválida!")
    end
    
    print()
    menu() -- Volta ao menu
end

-- Inicia o programa
print("Turtle Mineradora de Obsidiana carregado!")
print("Sistema de mineração automática com gerenciamento de inventário")
menu()
