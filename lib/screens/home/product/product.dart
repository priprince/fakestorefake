import 'package:fakestorefake/constants/common_widgets.dart';
import 'package:fakestorefake/constants/extensions.dart';
import 'package:fakestorefake/constants/loading.dart';
import 'package:fakestorefake/constants/logs.dart' show logger;
import 'package:fakestorefake/dependency/get_it.dart' show getIt;
import 'package:fakestorefake/repository/productRepository/product_repo.dart'
    show ProductRepo;
import 'package:fakestorefake/screens/home/product/bloc/product_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart'
    show BlocListener, BlocBuilder, BlocProvider;

class ProductScreen extends StatelessWidget {
  const ProductScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<ProductBloc, ProductState>(
      listener: (context, state) {
        if (state is ProductEmptyState) {
          CommonWidgets.showToast(state.message ?? "");
        }
        if (state is ProductLoadingState) {
          LoadingIndicator.show(context);
        } else {
          LoadingIndicator.hide();
        }
      },
      child: Column(
        children: [
          InkWell(
            onTap: () {
              BlocProvider.of<ProductBloc>(context).add(FetchProductEvent());
            },
            child: Container(
              height: 100,
              width: 100,
              color: Colors.green,
              child: Text("LIST"),
            ),
          ),
          Expanded(
            child: RefreshIndicator(
              onRefresh: () async {
                BlocProvider.of<ProductBloc>(context).add(FetchProductEvent());
              },
              child: ProductList(),
            ),
          ),
        ],
      ),
    );
  }
}

class ProductList extends StatelessWidget {
  const ProductList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductBloc, ProductState>(
      builder: (context, state) {
        if (state is ProductEmptyState) {
          return Center(child: Text(state.message ?? ""));
        }
        if (state is ProductLoadedState) {
          final products = state.products;
          return ListView.separated(
            shrinkWrap: true,
            itemCount: products.length,
            itemBuilder: (context, index) {
              final product = products[index];
              return ListTile(
                leading: SizedBox(
                  width: 20,
                  height: 30,
                  child: Image.network(
                    product.images!.first,
                    width: 20,
                    height: 30,
                    fit: BoxFit.contain,
                    errorBuilder: (context, error, stackTrace) => Text("error"),
                    loadingBuilder: (context, child, loadingProgress) {
                      final full = loadingProgress?.cumulativeBytesLoaded;
                      final ong = loadingProgress?.expectedTotalBytes;
                      logger.i("full ----$full -----omy ========$ong");

                      return child;
                    },
                  ),
                ),
                title: Text("${product.id}"),
                subtitle: Text("${product.title}"),
              );
            },
            separatorBuilder: (context, index) => SizedBox(height: 10),
          );
        }
        return SizedBox();
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
