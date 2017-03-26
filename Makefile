CC = gcc
CFLAGS = -std=gnu11 -Wall -g -pthread
OBJS = list.o threadpool.o merge_sort.o main.o

.PHONY: all clean test

$(GIT_HOOKS):
	@scripts/install-git-hooks
	@echo

GIT_HOOKS := .git/hooks/applied
all: $(GIT_HOOKS) sort tools/util-average

$(GIT_HOOKS):
	@scripts/install-git-hooks
	@echo

deps := $(OBJS:%.o=.%.o.d)
%.o: %.c
	$(CC) $(CFLAGS) -o $@ -MMD -MF .$@.d -c $<

sort: $(OBJS)
	$(CC) $(CFLAGS) -o $@ $(OBJS) -rdynamic

genData:
	uniq test_data/words.txt | sort -R > test_data/input.txt
	uniq test_data/words.txt | sort > test_data/expected.txt

tools/util-average: tools/util-average.c
	$(CC) $(CFLAGS) -o $@ $<

# Default variables for auto testing
THREADS ?= 4
TEST_DATA_FILE   ?= test_data/input.txt
SORTED_DATA_FILE ?= test_data/expected.txt
SORTED_RESULT    ?= output.txt

check: sort genData
	./sort $(THREADS) $(TEST_DATA_FILE) $(SORTED_RESULT)
	diff $(SORTED_DATA_FILE) $(SORTED_RESULT)

clean:
	rm -f $(OBJS) sort
	@rm -rf $(deps)
	rm -f output.txt

-include $(deps)
