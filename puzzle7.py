# %%
import numpy as np

DIRECTION_LIST = [-1, 1]

def choose_direction(prob_right, prob_left):
    return np.random.choice(
        DIRECTION_LIST, p=[prob_right, prob_left]
    )

def drink_once_strategy(N=30):
    total_time = 0
    drinked_chairs = []
    position_chairs = np.arange(start=1, stop=N + 1, step=1)
    index_chair = 0
    current_direction = 1
    total_drinks = 0
    while total_drinks < N:
        chair_to_drink = position_chairs[index_chair]
        if chair_to_drink not in drinked_chairs:
            prob_right = chair_to_drink / (N + 1)
            prob_left = 1 - prob_right
            current_direction = choose_direction(prob_right, prob_left)
            total_drinks += 1
            drinked_chairs.append(chair_to_drink)
        total_time += 1
        index_chair += current_direction
    return total_time - 1 


def drink_always_strategy(N=10):
    total_time = 0
    drinked_chairs = []
    position_chairs = np.arange(start=1, stop=N + 1, step=1)
    index_chair = 0
    current_direction = 1
    while drinked_chairs.__len__() < N:
        chair_to_drink = position_chairs[index_chair]
        if chair_to_drink not in drinked_chairs:
            drinked_chairs.append(chair_to_drink)
        prob_right = chair_to_drink / (N + 1)
        prob_left = (N - chair_to_drink + 1) / (N + 1)
        current_direction = choose_direction(prob_right, prob_left)
        total_time += 1
        index_chair += current_direction
    return total_time - 1


def play_kombucha_a(n=10000000, n_chairs=30):
    tempos = []
    for _ in range(n):
        total_time = drink_once_strategy(N=n_chairs)
        tempos.append(total_time)
    return np.array(tempos)


def play_kombucha_b(n=10000000, n_chairs=10):
    tempos = []
    for _ in range(n):
        total_time = drink_always_strategy(N=n_chairs)
        tempos.append(total_time)
    return np.array(tempos)

time_array_a = play_kombucha_a()
mean_time_a = time_array_a.mean()

time_array_b = play_kombucha_b()
mean_time_b = time_array_b.mean()

print(f"Average time received for a {mean_time_a}")
print(f"Average time received for b {mean_time_b}")
