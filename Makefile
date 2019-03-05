#
# Compiler flags
#
CC     = g++ -I./ -I./Imgui/
CFLAGS = -Wall
LIBS	= 
#
# Project files
#

rwildcard=$(foreach d,$(wildcard $1*),$(call rwildcard,$d/,$2) $(filter $(subst *,%,$2),$d))

FOLDERS = 

SRCS = $(call rwildcard, , *.cpp)
OBJS = $(SRCS:.cpp=.o)
EXE  = Logger

#
# Debug build settings
#
DBGDIR = debug
DBGEXE = $(DBGDIR)/$(EXE)
DBGOBJS = $(addprefix $(DBGDIR)/, $(OBJS))
DBGCFLAGS = -g -O0 -DDEBUG

#
# Release build settings
#
RELDIR = release
RELEXE = $(RELDIR)/$(EXE)
RELOBJS = $(addprefix $(RELDIR)/, $(OBJS))
RELCFLAGS = -O3 -Ofast -DNDEBUG -Werror -Wextra

.PHONY: all clean debug prep release remake run rund test

# Default build
all: prep release

#
# Debug rules
#
debug: $(DBGEXE)

$(DBGEXE): $(DBGOBJS)
	$(CC) $(CFLAGS) $(DBGCFLAGS) -o $(DBGEXE) $^ $(LIBS)

$(DBGDIR)/%.o: %.cpp
	$(CC) -c $(CFLAGS) $(DBGCFLAGS) -o $@ $<

#
# Release rules
#
release: $(RELEXE)

$(RELEXE): $(RELOBJS)
	$(CC) $(CFLAGS) $(RELCFLAGS) -o $(RELEXE) $^ $(LIBS)

$(RELDIR)/%.o: %.cpp
	$(CC) -c $(CFLAGS) $(RELCFLAGS) -o $@ $<

#
# Other rules
#
prep:
	@mkdir -p $(DBGDIR) $(RELDIR)
ifneq ($(FOLDERS),)
	@cd $(DBGDIR) && mkdir -p $(FOLDERS)
	@cd $(RELDIR) && mkdir -p $(FOLDERS)
endif

remake: clean all

clean:
	rm -f $(RELEXE) $(RELOBJS) $(DBGEXE) $(DBGOBJS) $(RELDIR)/*.o $(DBGDIR)/*.o
run:
	$(RELEXE)

rund:
	$(DBGEXE)

test:
	valgrind --leak-check=full -v $(DBGEXE)
