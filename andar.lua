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

-- Função principal para andar em linha
function andarEmLinha()
    print("Iniciando movimento em linha...")
    print("Pressione Ctrl+T para parar")
    
    while true do
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
    turtle.turnLeft()
    turtle.turnLeft()
    
    while detectarObsidiana() do
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
    print("4. Sair")
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
