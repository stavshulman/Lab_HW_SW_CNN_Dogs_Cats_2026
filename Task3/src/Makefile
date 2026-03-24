MAKEFLAGS += " -j2 "
CXX = g++
CFLAGS = -O3 -Wall

all: obj cnnSolver

cnnSolver: obj/cnnSolver.o obj/model.o obj/cnn.o obj/CAccelProxy.o obj/CConv2DProxy.o
	$(CXX) $(CFLAGS) obj/cnnSolver.o obj/model.o obj/cnn.o obj/CAccelProxy.o obj/CConv2DProxy.o -o cnnSolver -lm -lcma -lpthread

obj/cnnSolver.o: cnnSolver.cpp model.h cnn.h CAccelProxy.hpp CConv2DProxy.hpp
	$(CXX) -c $(CFLAGS) cnnSolver.cpp -o obj/cnnSolver.o

obj/model.o: model.cpp model.h cnn.h CAccelProxy.hpp CConv2DProxy.hpp
	$(CXX) -c $(CFLAGS) model.cpp -o obj/model.o

obj/cnn.o: cnn.cpp cnn.h model.h
	$(CXX) -c $(CFLAGS) cnn.cpp -o obj/cnn.o

obj/CAccelProxy.o: CAccelProxy.cpp CAccelProxy.hpp
	$(CXX) -c $(CFLAGS) CAccelProxy.cpp -o obj/CAccelProxy.o

obj/CConv2DProxy.o: CConv2DProxy.cpp CConv2DProxy.hpp CAccelProxy.hpp
	$(CXX) -c $(CFLAGS) CConv2DProxy.cpp -o obj/CConv2DProxy.o

obj:
	mkdir -p obj

clean:
	rm -f cnnSolver
	rm -rf obj/