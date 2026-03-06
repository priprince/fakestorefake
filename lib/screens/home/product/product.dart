import 'package:cached_network_image/cached_network_image.dart';
import 'package:fakestorefake/constants/logs.dart' show logger;
import 'package:fakestorefake/dependency/get_it.dart' show getIt;
import 'package:fakestorefake/model/product_model.dart' show Product;
import 'package:fakestorefake/repository/productRepository/product_repo.dart'
    show ProductRepo;
import 'package:fakestorefake/screens/home/product/bloc/product_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart' show BlocProvider, BlocSelector;
import 'package:skeletonizer/skeletonizer.dart';

class ProductScreen extends StatefulWidget {
  const ProductScreen({super.key});

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen>
    with SingleTickerProviderStateMixin {
  late final TabController _tabController;
  static const Map<String, dynamic> tabs = {
    "tab1": {"price": "Price < 50", "color": Colors.green},
    "tab2": {"price": "Price > 50", "color": Colors.red},
  };

  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            BlocProvider.of<ProductBloc>(context).add(FetchProductEvent());
          },
          child: Icon(Icons.add),
        ),
        backgroundColor: Colors.pink.shade100.withValues(alpha: 0.2),
        body: Column(
          children: [
            TabBar(
              controller: _tabController,
              onTap: (value) {
                // logger.e("on tap ====$value");
                BlocProvider.of<ProductBloc>(
                  context,
                ).add(TabBarChangeEvent(value));
              },
              tabs: [
                ...tabs.entries.map((e) {
                  final value = tabs[e.key];
                  return Container(
                    width: 150,
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(color: value['color']),
                    alignment: Alignment.center,
                    child: Text(value['price']),
                  );
                }),
              ],
            ),
            Expanded(
              child: TabBarView(
                physics: NeverScrollableScrollPhysics(),
                controller: _tabController,
                children: [ProductList(), ProductList()],
              ),
            ),
          ],
        ),
      ),
    );
    //  BlocListener<ProductBloc, ProductState>(
    //   listenWhen: (previous, current) =>
    //       previous.productStatus != current.productStatus,
    //   listener: (context, state) {
    //     if (state.productStatus == ProductStatus.loading) {
    //       LoadingIndicator.show(context);
    //     } else {
    //       LoadingIndicator.hide();
    //     }
    //   },
    //   child: ,
    // );
  }
}

class ProductList extends StatelessWidget {
  const ProductList({super.key});
  @override
  Widget build(BuildContext context) {
    return BlocSelector<ProductBloc, ProductState, ProductStatus>(
      selector: (s) => s.productStatus,
      builder: (context, state) {
        final status = state;
        switch (status) {
          case ProductStatus.success:
            // return Center(child: Text("success"));
            return const RefreshWidget();
          case ProductStatus.error:
            return const Center(child: Text("NO PRODUCTS"));
          default:
            return const SizedBox.shrink();
        }
      },
    );
  }
}

class RefreshWidget extends StatelessWidget {
  const RefreshWidget({super.key});
  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        logger.d("on refresh");
        BlocProvider.of<ProductBloc>(context).add(FetchProductEvent());
      },
      child: BlocSelector<ProductBloc, ProductState, List<Product>>(
        selector: (state) => state.products ?? [],
        builder: (context, state) {
          final products = state;
          if (products.isEmpty) {
            return const Center(child: Text("No products available"));
          }
          return ListView.separated(
            addAutomaticKeepAlives: false,
            addRepaintBoundaries: false,
            addSemanticIndexes: false,
            physics: AlwaysScrollableScrollPhysics(),
            itemCount: products.length,
            itemBuilder: (context, index) {
              final product = products[index];
              return SingleProductTile(product.id!);
            },
            separatorBuilder: (context, index) => SizedBox(height: 10),
          );
        },
      ),
    );
  }
}

class SingleProductTile extends StatelessWidget {
  const SingleProductTile(this.id, {super.key});
  final String id;
  @override
  Widget build(BuildContext context) {
    return BlocSelector<ProductBloc, ProductState, TileModel>(
      selector: (state) => TileModel(
        product: state.productMap![id]!,
        isSelected: state.selectedIds?.contains(id) ?? false,
      ),
      builder: (context, model) {
        return InkWell(
          onTap: () =>
              BlocProvider.of<ProductBloc>(context).add(ProductSelectEvent(id)),
          child: RepaintBoundary(
            child: Skeletonizer(
              enabled: model.isSelected,
              child: SingleTileOnly(model.product),
              //  BlocSelector<ProductBloc, ProductState, Product>(
              //   selector: (state) => state.productMap![id]!,
              //   builder: (context, state) {
              //     final product = state;
              //     return SingleTileOnly(product);
              //   },
              // ),
            ),
          ),
        );
      },
    );
  }
}

class SingleTileOnly extends StatelessWidget {
  const SingleTileOnly(this.product, {super.key});

  final Product product;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
      leading: SizedBox(
        width: 120,
        height: 150,
        child: CachedNetworkImage(
          memCacheWidth: 240,
          memCacheHeight: 300,
          imageUrl: product.images!.first,
          width: 120,
          height: 150,
          fit: BoxFit.cover,
          errorWidget: (context, url, error) => Icon(Icons.error),
        ),
      ),
      dense: true,
      selectedTileColor: Colors.green.shade200,
      trailing: SizedBox(
        width: 80,
        child: Row(
          children: [
            ThumbWidget(product.id!),
            SizedBox(width: 25),
            FavoriteWidget(product.id!),
          ],
        ),
      ),
      title: Text("${product.id} = ${product.price}"),
      subtitle: Text("${product.title}"),
    );
  }
}

class FavoriteWidget extends StatelessWidget {
  const FavoriteWidget(this.productId, {super.key});
  final String productId;
  @override
  Widget build(BuildContext context) {
    return BlocSelector<ProductBloc, ProductState, bool>(
      selector: (state) => state.favoriteIds!.contains(productId),
      builder: (context, isFavorited) {
        return InkWell(
          onTap: () => BlocProvider.of<ProductBloc>(
            context,
          ).add(ProductFavoriteEvent(productId)),
          child: Icon(isFavorited ? Icons.favorite : Icons.favorite_border),
        );
      },
    );
  }
}

class ThumbWidget extends StatelessWidget {
  const ThumbWidget(this.productId, {super.key});
  final String productId;
  @override
  Widget build(BuildContext context) {
    return BlocSelector<ProductBloc, ProductState, bool>(
      selector: (state) => state.likedIds!.contains(productId),
      builder: (context, isLiked) {
        return InkWell(
          onTap: () => BlocProvider.of<ProductBloc>(
            context,
          ).add(ProductLikeEvent(productId)),
          child: Icon(
            isLiked ? Icons.thumb_up_alt_rounded : Icons.thumb_up_alt_outlined,
          ),
        );
      },
    );
  }
}

class ProductPage extends StatelessWidget {
  const ProductPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProductBloc(getIt<ProductRepo>()),
      child: const ProductScreen(),
    );
  }
}
