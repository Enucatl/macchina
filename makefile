.PHONY: all clean

CC := g++
CFLAGS := -std=c++11 -O3
SRC := src
BUILDDIR := build
TARGET := bin/drafts
INC := -I include 
#-I /usr/include

SDLLIB := -lSDL2 -lSDL2_image -lpng12 
LIB := -lncurses -lboost_program_options $(SDLLIB)

all: drafts

#utilities

$(BUILDDIR)/utils.o : $(SRC)/utils.cpp $(SRC)/utils.h
	g++ $(CFLAGS) -c $(SRC)/utils.cpp -o $(BUILDDIR)/utils.o $(INC) $(LIB)

#board representation

$(BUILDDIR)/boardrep.o : $(SRC)/boardrep.cpp $(SRC)/boardrep.h
	g++ $(CFLAGS) -c $(SRC)/boardrep.cpp -o $(BUILDDIR)/boardrep.o $(INC) $(LIB)

#engine utilities/data structures

$(BUILDDIR)/hheuristic.o : $(SRC)/hheuristic.cpp $(SRC)/hheuristic.h $(SRC)/boardrep.h
	g++ $(CFLAGS) -c $(SRC)/hheuristic.cpp -o $(BUILDDIR)/hheuristic.o $(INC) $(LIB)

$(BUILDDIR)/database.o : $(SRC)/database.cpp $(SRC)/database.h $(SRC)/boardrep.h
	g++ $(CFLAGS) -c $(SRC)/database.cpp -o $(BUILDDIR)/database.o $(INC) $(LIB)

$(BUILDDIR)/ttable.o : $(SRC)/ttable.cpp $(SRC)/ttable.h $(SRC)/boardrep.h $(SRC)/utils.h
	g++ $(CFLAGS) -c $(SRC)/ttable.cpp -o $(BUILDDIR)/ttable.o $(INC) $(LIB)

#graphics and gui

$(BUILDDIR)/graphics.o : $(SRC)/graphics.cpp $(SRC)/boardrep.h
	g++ $(CFLAGS) -c $(SRC)/graphics.cpp -o $(BUILDDIR)/graphics.o $(INC) $(LIB)

#engine

$(BUILDDIR)/engine.o : $(SRC)/engine.cpp $(SRC)/engine.h $(SRC)/boardrep.h $(SRC)/hheuristic.h $(SRC)/database.h
	g++ $(CFLAGS) -c $(SRC)/engine.cpp -o $(BUILDDIR)/engine.o $(INC) $(LIB)

#main program

$(BUILDDIR)/drafts.o : $(SRC)/drafts.cpp $(SRC)/boardrep.h $(SRC)/hheuristic.h $(SRC)/database.h $(SRC)/ttable.h $(SRC)/engine.h $(SRC)/graphics.h
	g++ $(CFLAGS) -c $(SRC)/drafts.cpp -o $(BUILDDIR)/drafts.o $(INC) $(LIB)

#linking

$(TARGET): $(BUILDDIR)/drafts.o $(BUILDDIR)/boardrep.o $(BUILDDIR)/hheuristic.o $(BUILDDIR)/database.o $(BUILDDIR)/ttable.o $(BUILDDIR)/utils.o $(BUILDDIR)/engine.o $(BUILDDIR)/graphics.o
	$(CC) $(CFLAGS) $(BUILDDIR)/drafts.o $(BUILDDIR)/boardrep.o $(BUILDDIR)/hheuristic.o $(BUILDDIR)/database.o $(BUILDDIR)/ttable.o $(BUILDDIR)/utils.o $(BUILDDIR)/engine.o $(BUILDDIR)/graphics.o -o $(TARGET) $(INC) $(LIB)

drafts : $(TARGET)
	cp $(TARGET) drafts

#profile: $(SRC)/drafts.cpp
#	$(CC) -pg -std=c++11 -O3 $(SRC)/drafts.cpp -o $(TARGET)_profiling $(INC) $(LIB)

clean:
	rm -f drafts bin/* $(BUILDDIR)/*
