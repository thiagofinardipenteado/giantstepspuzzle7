clear
clc
close

N = 30;
nsim = 1e6;
i = 1;

path = 'D:\Programas\Puzzle\Simulacoes\N';
n_ext = size(dir([path,num2str(N),'/*.mat']),1) + 1;

while 0 == 0
    for i = 1:nsim
        players = zeros(1,N);
        chair_to_drink = 1;
        t = 0;
        choose_direction = 0;

        while sum(players) ~= N
            choose_direction_prev = choose_direction;

            % 1 - Bebeu
            players(chair_to_drink) = 1;

            % 2 - Escolheu para onde passar
            p_right = chair_to_drink / (N + 1);
            choose_to_drink = (1 - 2*(rand() < p_right));

            % 3 - Passou o copo
            chair_to_drink = (chair_to_drink + choose_to_drink) * (choose_to_drink == choose_direction_prev) + ...
                (chair_to_drink + choose_to_drink * sum(players)) * (choose_to_drink ~= choose_direction_prev);

            chair_to_drink = chair_to_drink + N * (chair_to_drink < 1) + ...
                                            - N * (chair_to_drink > N);

            tf = (choose_to_drink == choose_direction_prev) + ...
                  sum(players) * (choose_to_drink ~= choose_direction_prev);
            t = t + tf;
        end

        X(i) = t - tf;
    end
    
    cd Simulacoes
    cd(['N',num2str(N)])
    
    save(['X',num2str(N,'%03d'),num2str(n_ext,'%07d')],'X')
    clear X
    
    cd ..
    cd ..
    n_ext = n_ext + 1;
end