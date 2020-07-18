汇编源文件：memcpy.S
测试源文件：test.c（文件夹中另外三个test是小尺寸测试和库函数测试）

算法简介：
主体部分是使用avx指令集中的vmovupd指令，一次搬运32个字节。在搬运前，先检查总搬运字节数是否被128整除，将余数那部分使用小尺寸策略搬运完成，剩下的大块再循环使用vmovupd完成搬运，4条指令为一个循环。小尺寸的策略是不断检查剩下部分的大小在哪个区间内，如果大于等于32字节，就用vmovupd搬运，如果大于等于16字节用vmovups搬运，大于等于8字节用mov rcx搬运，大于等于4字节用mov ecx搬运，大于等于2字节用mov cx搬运，最后一个字节用mov cl搬运。
C语言测试程序部分，宏定义中OFFSET_1和OFFSET_2是src和dest的偏移，用于模拟非对齐的情况。先对准备搬运的内存赋值，然后用gettimeofday记录搬运时间，最后逐字节检查是否正确并输出。每次测试的时候都是重新分配指针，减少cache初始状态对测试结果的影响，结果更加准确。对于小尺寸的测试，为了测试结果的准确性，使用rdtsc读取周期数计算。

编译运行命令：
编译 make memcpy
运行 ./memcpytest
反汇编 make disassembly
清空 make clean

测试用例：
大规模：OFFSET_1=1 OFFSET_2=2 N=64MB
小规模：N从1到120

测试结果：
搬运64MB的数据，时间花费在21000us左右，用于对比，库函数在32000us左右。
小规模测试，搬运10000次，周期数为20万到30万，用于对比，库函数在35万到45万。