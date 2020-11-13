# First task
def my_range(count=None):
    sequence = []
    counter = 0
    while counter != count:
        sequence.append(counter)
        counter += 1
    return sequence


# Second task
def is_lucky(ticket_num):
    list_of_digits_ticket_num = list(map(int, list(str(ticket_num))))
    delimiter_ind = int(len(list_of_digits_ticket_num)/2)
    return sum(list_of_digits_ticket_num[:delimiter_ind]) == sum(list_of_digits_ticket_num[delimiter_ind:])


if __name__ == '__main__':
    # print(my_range())
    print(is_lucky(223243))

