MIX = mix
APP = eat
BIN_DIR = bin

all: compile release

compile:
	$(MIX) deps.get
	$(MIX) compile

release: compile
	$(MIX) escript.build
	mkdir -p $(BIN_DIR)
	mv $(APP) $(BIN_DIR)/$(APP)

clean:
	$(MIX) clean
	rm -f $(BIN_DIR)/$(APP)

run: release
	$(BIN_DIR)/$(APP)

.PHONY: all compile release clean run
