# UlasBuku: Project Tugas Kelompok A04 PBP
- Link Repository: [Click](https://github.com/yps-a04/ulasbuku_mobile)
- Link *Website* Proyek UTS: (soon)
- Berita acara: [Click](https://univindonesia-my.sharepoint.com/:x:/g/personal/williams_office_ui_ac_id/EQLHHcRruOFNvy_njxDlPowBzr3vO4qu2B1SISeZ8JKbiQ?e=ScN18i)

# Anggota Kelompok
1. [Ghaisan Luqyana Aqila - 2206830460](https://github.com/Ghaisan007)
2. [Williams - 2206820440](https://github.com/NtapSlur)
3. [Yasmine Putri Viryadhani - 2206081862](https://github.com/sdikyarts)
4. [Daffa Akmal Zuhdii - 2206083243](https://github.com/Daffa2101)
5. [Muhammad Iqbal - 2206082152](https://github.com/Liqba)

# Tentang Aplikasi
## UlasBuku
Nama aplikasi yang kami pilih adalah **UlasBuku** yang berfungsi untuk memberi ulasan kepada buku buku

## Tema Aplikasi
Tema yang kami gunakan adalah **<i>aplikasi review</i> buku**

## Latar Belakang
- Data menunjukkan bahwa masyarakat di Indonesia minim akan literasi. Hal ini disebabkan oleh banyak hal, seperti kurangnya minat dalam membaca dan kemalasan yang timbul.
- Kita perlu untuk meningkatkan keinginan masyarakat dalam membaca, salah satunya adalah dengan merekomendasikan buku-buku yang sesuai dengan minat masyarakat beserta ulasannya agar masyarakat tahu mana buku yang bagus untuk dibaca.
- Oleh karena itu, kita berkeinginan untuk membuat UlasBuku ini yang dapat mewadahi keinginan masyarakat untuk membaca dan memberikan ulasan terkait hasil bacaan mereka.

## Tujuan Aplikasi
1. Meningkatkan minat baca masyarakat
2. Melatih masyarakat untuk menulis ulasan
3. Menjadi referensi masyarakat dalam memilih buku yang tepat untuk dibaca

## Implementasi Modul
#### Modul <code>home</code> by Daffa Akmal Zuhdii:
- Menampilkan *list* daftar buku
- Menambahkan navigasi ke *detail page*
- Menambahkan fitur search

#### Modul <code>book_details</code> by Yasmin Putri Viryadhani:
- Menampilkan detail buku beserta reviewnya
- Menambahkan fitur *add review*
- Menambahkan tombol *add to bookmark*

#### Modul <code>profile</code> by Williams:
- Menampilkan detail profil user/admin
- Menampilkan review-review yang telah ditambahkan oleh user tersebut
- Menampilkan author-author preference yang sudah dipilih oleh user
- Membuat form untuk menambah preference

#### Modul <code>bookmark</code> by Muhammad Iqbal:
- Menambahkan list buku yang telah dibookmark user

#### Modul <code>admin</code> by Ghaisan Luqyana Aqila:
- Menambahkan fitur add/delete/edit buku
- Menambahkan fitur delete user

## Sumber <i>dataset</i> katalog buku 
- Kelompok kami menggunakan **Kaggle** sebagai sumber dataset buku-buku yang tersedia di UlasBuku
- Dataset Kaggle yang kami pilih bersumber dari **GoodReads** dan **Amazon**
    - [Goodreads](https://www.kaggle.com/datasets/jealousleopard/goodreadsbooks)
    - [Amazon](https://www.kaggle.com/datasets/saurabhbagchi/books-dataset)

## <i>Role</i> Pengguna
- Admin:
    Login (tidak bisa register) -> Home Page -> Edit/add/delete books (Admin Exclusive) -> Show Database -> Page per buku -> Profile
- User biasa
    Login/Register -> Initial Recommendation (User Biasa Exclusive) -> Home Page -> Edit/add/delete books (Admin Exclusive) -> Show Database -> Page per buku -> Profile


## Alur Pengintegrasian dengan web Django
- Melakukan integrasi antara front-end dengan back-end pada Rest API ulasbuku menggunakan konsep asynchronous programming
- Berikut adalah langkah-langkah yang akan dilakukan untuk mengintegrasikan aplikasi dengan server web.
- Mengimplementasikan sebuah wrapper class dengan menggunakan library http dan map untuk mendukung penggunaan cookie-based authentication pada aplikasi.
- Mengimplementasikan REST API pada Django (views.py) dengan menggunakan JsonResponse atau Django JSON Serializer.
