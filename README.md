# a199-flutter-expert-project

Repository ini merupakan starter project submission kelas Flutter Expert Dicoding Indonesia.

---
[![Codemagic build status](https://api.codemagic.io/apps/635ca74c6520fb7df787ae05/635ca74c6520fb7df787ae04/status_badge.svg)](https://codemagic.io/apps/635ca74c6520fb7df787ae05/635ca74c6520fb7df787ae04/latest_build)


## Tips Submission Awal

Pastikan untuk memeriksa kembali seluruh hasil testing pada submissionmu sebelum dikirimkan. Karena kriteria pada submission ini akan diperiksa setelah seluruh berkas testing berhasil dijalankan.


## Tips Submission Akhir

Jika kamu menerapkan modular pada project, Anda dapat memanfaatkan berkas `test.sh` pada repository ini. Berkas tersebut dapat mempermudah proses testing melalui *terminal* atau *command prompt*. Sebelumnya menjalankan berkas tersebut, ikuti beberapa langkah berikut:
1. Install terlebih dahulu aplikasi sesuai dengan Operating System (OS) yang Anda gunakan.
    - Bagi pengguna **Linux**, jalankan perintah berikut pada terminal.
        ```
        sudo apt-get update -qq -y
        sudo apt-get install lcov -y
        ```
    
    - Bagi pengguna **Mac**, jalankan perintah berikut pada terminal.
        ```
        brew install lcov
        ```
    - Bagi pengguna **Windows**, ikuti langkah berikut.
        - Install [Chocolatey](https://chocolatey.org/install) pada komputermu.
        - Setelah berhasil, install [lcov](https://community.chocolatey.org/packages/lcov) dengan menjalankan perintah berikut.
            ```
            choco install lcov
            ```
        - Kemudian cek **Environtment Variabel** pada kolom **System variabels** terdapat variabel GENTHTML dan LCOV_HOME. Jika tidak tersedia, Anda bisa menambahkan variabel baru dengan nilai seperti berikut.
            | Variable | Value|
            | ----------- | ----------- |
            | GENTHTML | C:\ProgramData\chocolatey\lib\lcov\tools\bin\genhtml |
            | LCOV_HOME | C:\ProgramData\chocolatey\lib\lcov\tools |
        
2. Untuk mempermudah proses verifikasi testing, jalankan perintah berikut.
    ```
    git init
    ```
3. Kemudian jalankan berkas `test.sh` dengan perintah berikut pada *terminal* atau *powershell*.
    ```
    test.sh
    ```
    atau
    ```
    ./test.sh
    ```
    Proses ini akan men-*generate* berkas `lcov.info` dan folder `coverage` terkait dengan laporan coverage.
4. Tunggu proses testing selesai hingga muncul web terkait laporan coverage.


## ----------------- KELENGKAPAN BERKAS SUBMISSION ---------------

### Continuous Integration menggunakan Codemagic :
![image](https://user-images.githubusercontent.com/98727707/198929514-b424d78f-6d99-4324-9af7-9438324dfe81.png)
![image](https://user-images.githubusercontent.com/98727707/198930193-36020452-597e-423a-86c3-606a657f1af0.png)
![image](https://user-images.githubusercontent.com/98727707/198930245-8272616f-4bd8-4d11-a075-8e52265d8fee.png)


### Firebase Crashlytics : 
![image](https://user-images.githubusercontent.com/98727707/198862874-adc5e3fd-697b-47fe-b142-ca35bbf5a1ff.png)

### Setelah ditambahkan code utk mentrigger crashlytics :
![image](https://user-images.githubusercontent.com/98727707/198862934-dd163001-a429-43dd-b7f2-bace433b7bb2.png)
![image](https://user-images.githubusercontent.com/98727707/198862969-0ef3f4ab-e139-4b6e-93fb-8e094b48d873.png)

### Firebase Analytics :
![image](https://user-images.githubusercontent.com/98727707/198863021-355e7dcf-80cd-48f9-8965-1bfe633a92b3.png)




