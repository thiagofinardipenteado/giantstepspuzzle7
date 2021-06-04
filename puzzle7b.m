clear
clc
close

N = 10;
nsim = 1e6;
i = 1;

path = 'D:\Programas\Puzzle\Simulacoes\Nb';
n_ext = size(dir([path,num2str(N),'/*.mat']),1) + 1;

while 0 == 0
    for i = 1:nsim
        players = zeros(1,N);
        chair_to_drink = 1;
        t = 0;

        while sum(players) ~= N
            % 1 - Bebeu
            players(chair_to_drink) = 1;
            
            % 2 - Bebeu e escolheu para onde passar
            prob_right = chair_to_drink / (N + 1);
            choose_direction = (1 - 2*(rand() < prob_right));

            % 3 - Passou o copo
            chair_to_drink = chair_to_drink + choose_direction;
            chair_to_drink = N * (chair_to_drink == 0) + ...
                             1 * (chair_to_drink == N+1) + ...
                 chair_to_drink * (chair_to_drink ~= 0 && chair_to_drink ~= N+1);

            t = t + 1;
        end

        X(i) = t - 1;
    end
    
    cd Simulacoes
    cd(['Nb',num2str(N)])
    
    save(['Xb',num2str(N,'%03d'),num2str(n_ext,'%06d')],'X')
    clear X
    
    cd ..
    cd ..
    n_ext = n_ext + 1;
end
